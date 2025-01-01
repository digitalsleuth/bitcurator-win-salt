# Name: siegfried
# Website: https://www.itforarchivists.com/siegfried/
# Description: Signature-based file format identification tool
# Category: Archival
# Author: Richard Lehane
# License: Apache License (https://github.com/richardlehane/siegfried/blob/main/LICENSE.txt)
# Version: 1.11.1
# Notes: sf.exe, roy.exe

{% set version = '1.11.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = '89188357e78f4405f0c7d2b71d24668d9f9dd83ecc5df9901dd7fdc12d77b809' %}

siegfried-download:
  file.managed:
    - name: 'C:\salt\tempdownload\siegfried_{{ version | replace(".","-") }}_win64.zip'
    - source: 'https://github.com/richardlehane/siegfried/releases/download/v{{ version }}/siegfried_{{ version | replace(".","-") }}_win64.zip'
    - source_hash: sha256={{ hash }}
    - makedirs: True

siegfried-extract:
  archive.extracted:
    - name: '{{ inpath }}\siegfried\'
    - enforce_toplevel: False
    - source: 'C:\salt\tempdownload\siegfried_{{ version | replace(".","-") }}_win64.zip'
    - overwrite: True
    - require:
      - file: siegfried-download

siegfried-update:
  cmd.run:
    - name: '{{ inpath }}\siegfried\sf.exe -update'
    - shell: cmd
    - require:
      - archive: siegfried-extract

siegfried-path:
  win_path.exists:
    - name: '{{ inpath }}\siegfried'
    - require:
      - file: siegfried-download

