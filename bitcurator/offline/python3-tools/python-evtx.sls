# Name: python-evtx
# Website: https://github.com/williballenthin/python-evtx
# Description: Pure Python parser for Windows Event Log (.evtx) files
# Category: Archival
# Author: Willi Ballenthin
# License: Apache License 2.0 (https://github.com/williballenthin/python-evtx/blob/master/LICENSE.TXT)
# Version: 0.8.1
# Notes: evtx_dump.py, evtx_dump_chunk_slack.py, evtx_dump_json.py, evtx_info.py

{% set version = '0.8.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exists = salt['file.directory_exists'](downloads + '\\python-evtx\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

python-evtx-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages .'
    - cwd: '{{ downloads }}\python-evtx\'
    - require:
      - sls: bitcurator.offline.packages.python3

python-evtx-import-fix-offline:
  file.replace:
    - name: 'C:\Program Files\Python311\Scripts\evtx_eid_record_numbers.py'
    - pattern: 'from filter_records'
    - repl: 'from evtx_scripts.evtx_filter_records'
    - count: 1
    - require:
      - cmd: python-evtx-install-offline

{% else %}
{{ downloads }}\python-evtx\packages does not exist - not installing:
  test.nop
{% endif %}
