#!/usr/bin/env python3
import argparse
import re
import sys
from pathlib import Path

CATEGORIES = ("installers", "packages", "python3-tools", "standalones")
PREFIXES = ("", "downloads", "offline")
CENTRAL = Path("_macros") / "hashes.jinja"
HEADER_RE = re.compile(r"^(# Version:[ \t]*)([^\r\n]*?)([ \t]*)(?=\r?$)", re.M)


def var_re(var):
    return re.compile(
        rf"^(\s*\{{%-?\s*set\s+{re.escape(var)}\s*=\s*)(['\"])([^'\"]*)\2(\s*-?%\}})", re.M
    )


def find_files(root, name):
    return [
        path
        for prefix in PREFIXES
        for category in CATEGORIES
        if (path := root / prefix / category / f"{name}.sls").is_file()
    ]


def update_text(text, header_version, sets):
    changes = []
    if header_version is not None:
        new_text = HEADER_RE.sub(lambda m: m.group(1) + header_version + m.group(3), text)
        if new_text != text:
            changes.append("# Version")
        text = new_text
    for var, value in sets.items():
        regex = var_re(var)
        new_text = regex.sub(lambda m: m.group(1) + m.group(2) + value + m.group(2) + m.group(4), text)
        if new_text != text:
            changes.append(var)
        elif var == "version" and not regex.search(text):
            changes.append("NOTE: no literal 'set version' line")
        text = new_text
    return text, changes


def update_central(text, name, new):
    # returns (text, changed vars, handled vars), or None if the state has no entry
    m = re.search(rf"^  '{re.escape(name)}': (.*?),[ \t]*$", text, re.M)
    if not m:
        return None
    value, changed, handled = m.group(1), [], []
    if value.startswith("'"):
        if "hash" in new:
            handled.append("hash")
            if value.strip("'") != new["hash"]:
                value, changed = f"'{new['hash']}'", ["hash"]
    else:
        for var, new_value in new.items():
            hm = re.search(rf"'{re.escape(var)}': '([^']*)'", value)
            if not hm:
                continue
            handled.append(var)
            if hm.group(1) != new_value:
                value = value[:hm.start(1)] + new_value + value[hm.end(1):]
                changed.append(var)
    return text[:m.start(1)] + value + text[m.end(1):], changed, handled


def get_value(root, name, var):
    central = root / CENTRAL
    if central.is_file():
        m = re.search(rf"^  '{re.escape(name)}': (.*?),[ \t]*$", central.read_bytes().decode("utf-8"), re.M)
        if m and m.group(1).startswith("'") and var == "hash":
            return m.group(1).strip("'")
        if m and not m.group(1).startswith("'"):
            hm = re.search(rf"'{re.escape(var)}': '([^']*)'", m.group(1))
            if hm:
                return hm.group(1)
    for path in find_files(root, name):
        vm = var_re(var).search(path.read_bytes().decode("utf-8"))
        if vm:
            return vm.group(3)
    return None


def main():
    parser = argparse.ArgumentParser(description="Update version/hash values for bitcurator Salt states")
    parser.add_argument("name", help="state file name without .sls")
    parser.add_argument("--version")
    parser.add_argument("--hash", dest="hash_", help="the state's hash (sha256)")
    parser.add_argument("--set-hash", action="append", metavar="VAR=HEX", help="another named hash (repeatable)")
    parser.add_argument("--set", dest="set_values", action="append", metavar="VAR=VALUE",
                        help="any other value the download needs, e.g. commit, subver (repeatable)")
    parser.add_argument("--get", metavar="VAR", help="print the current value of VAR and exit")
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parent / "bitcurator",
                        help="path to the bitcurator folder (default: next to this script)")
    parser.add_argument("-n", "--dry-run", action="store_true")
    args = parser.parse_args()

    if args.get:
        value = get_value(args.root, args.name, args.get)
        if value is None:
            print(f"error: no value for {args.get} in {args.name}", file=sys.stderr)
            return 1
        print(value)
        return 0

    hashes = {"hash": args.hash_} if args.hash_ else {}
    for item in args.set_hash or []:
        var, _, value = item.partition("=")
        if not re.fullmatch(r"\w*hash\w*", var):
            parser.error(f"--set-hash expects VAR=HEX, got {item!r}")
        hashes[var] = value
    others = {}
    for item in args.set_values or []:
        var, _, value = item.partition("=")
        if not re.fullmatch(r"\w+", var) or not value:
            parser.error(f"--set expects VAR=VALUE, got {item!r}")
        if re.search(r"""['"\\{}]""", value):
            parser.error(f"{var}: value may not contain quotes, backslashes or braces")
        others[var] = value
    if args.version is None and not hashes and not others:
        parser.error("nothing to update: pass --version, --hash, --set-hash or --set")
    for var, value in hashes.items():
        if not re.fullmatch(r"[0-9A-Fa-f]{64}", value):
            parser.error(f"{var} must be a 64-character hex SHA256")
    updates = {**hashes, **others}

    files = find_files(args.root, args.name)
    if not files:
        print(f"No state files named {args.name}.sls found under {args.root}", file=sys.stderr)
        return 1

    # everything is computed first; nothing is written if a value can't be applied
    writes, report, handled = [], [], set()
    verb = "would update" if args.dry_run else "updated"
    central_path = args.root / CENTRAL
    if updates and central_path.is_file():
        result = update_central(central_path.read_bytes().decode("utf-8"), args.name, updates)
        if result:
            new_central, changed, handled = result[0], result[1], set(result[2])
            if handled:
                report.append(f"{verb if changed else 'unchanged'}  {CENTRAL.as_posix()}  ({', '.join(changed) or args.name})")
            if changed:
                writes.append((central_path, new_central.encode("utf-8")))

    texts = {}
    for path in files:
        rel = path.relative_to(args.root).as_posix()
        sets = {"version": args.version} if args.version is not None else {}
        sets.update(updates)
        texts[path] = path.read_bytes().decode("utf-8")
        new_text, changes = update_text(texts[path], args.version, sets)
        if new_text == texts[path]:
            report.append(f"unchanged  {rel}  ({', '.join(changes)})" if changes else f"unchanged  {rel}")
            continue
        writes.append((path, new_text.encode("utf-8")))
        report.append(f"{verb}  {rel}  ({', '.join(changes)})")

    unapplied = sorted(
        var for var in updates if var not in handled and not any(var_re(var).search(t) for t in texts.values())
    )
    if unapplied:
        print(f"error: {', '.join(unapplied)} can't be applied to {args.name}: no such key in its hashes.jinja "
              f"entry and no literal `set` line in any copy. Nothing was written.", file=sys.stderr)
        return 2

    print("\n".join(report))
    if not args.dry_run:
        for path, data in writes:
            path.write_bytes(data)
    return 0


if __name__ == "__main__":
    sys.exit(main())
