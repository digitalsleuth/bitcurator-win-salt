# Name: python-evtx
# Website: https://github.com/williballenthin/python-evtx
# Description: Pure Python parser for Windows Event Log (.evtx) files
# Category: Archival
# Author: Willi Ballenthin
# License: Apache License 2.0 (https://github.com/williballenthin/python-evtx/blob/master/LICENSE.TXT)
# Version: 0.8.1
# Notes: evtx_dump.py, evtx_dump_chunk_slack.py, evtx_dump_json.py, evtx_info.py

{% set version = '0.8.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set commit = get_hash('python-evtx', 'commit') %}

include:
  - bitcurator.packages.git
  - bitcurator.standalones.portable-python3

python-evtx-clone-download-only:
  git.latest:
    - name: https://github.com/williballenthin/python-evtx.git
    - target: '{{ downloads }}\python-evtx'
    - rev: '{{ commit }}'
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git

python-evtx-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages . setuptools wheel'
    - cwd: '{{ downloads }}\python-evtx'
    - require:
      - git: python-evtx-clone-download-only
      - sls: bitcurator.standalones.portable-python3
