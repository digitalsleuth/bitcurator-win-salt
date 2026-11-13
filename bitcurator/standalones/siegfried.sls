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
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('siegfried') %}

include:
  - bitcurator.config.shims

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

{% for exe in ['sf', 'roy'] %}
{{ exe }}-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\siegfried\{{ exe }}.exe -OutPath {{ inpath }}\shims\{{ exe }}.exe'
    - require:
      - archive: siegfried-extract
      - sls: bitcurator.config.shims
{% endfor %}

