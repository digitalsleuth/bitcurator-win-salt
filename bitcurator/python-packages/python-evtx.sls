# Name: python-evtx
# Website: https://github.com/williballenthin/python-evtx
# Description: Pure Python parser for Windows Event Log (.evtx) files
# Category:
# Author: Willi Ballenthin
# License: Apache License 2.0 (https://github.com/williballenthin/python-evtx/blob/master/LICENSE.TXT)
# Version: 0.8.1
# Notes: evtx_dump.py, evtx_dump_chunk_slack.py, evtx_dump_json.py, evtx_info.py

{% set version = '0.8.1' %}
{% set commit = '1a1357accd3a75524794a6d6dcdec03c09e1660d' %}

include:
  - bitcurator.packages.python3

python-evtx:
  pip.installed:
    - name: git+https://github.com/williballenthin/python-evtx.git@{{ commit }}
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3

python-evtx-import-fix:
  file.replace:
    - name: 'C:\Program Files\Python310\Scripts\evtx_eid_record_numbers.py'
    - pattern: 'from filter_records'
    - repl: 'from evtx_scripts.evtx_filter_records''
    - count: 1
    - require:
      - pip: python-evtx
