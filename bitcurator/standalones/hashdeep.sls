# Name: hashdeep
# Website: https://github.com/jessek/hashdeep
# Description: 
# Category: Archival
# Author: Jesse Kornblum
# License: GNU General Public License v2 (https://github.com/jessek/hashdeep/blob/master/COPYING)
# Version: 4.4
# Notes: 

{% set version = '4.4' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('hashdeep') %}

include:
  - bitcurator.config.shims

hashdeep-download:
  file.managed:
    - name: 'C:\salt\tempdownload\md5deep-{{ version }}.zip'
    - source: https://github.com/jessek/hashdeep/releases/download/v{{ version }}/md5deep-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

hashdeep-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\md5deep-{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: hashdeep-download

hashdeep-rename:
  file.rename:
    - name: '{{ inpath }}\hashdeep'
    - source: '{{ inpath }}\md5deep-{{ version }}'
    - force: True
    - require:
      - archive: hashdeep-extract

{% for exe in ['hashdeep', 'md5deep', 'sha1deep', 'sha256deep', 'tigerdeep', 'whirlpooldeep'] %}
{{ exe }}-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\hashdeep\{{ exe }}64.exe -OutPath {{ inpath }}\shims\{{ exe }}.exe'
    - require:
      - file: hashdeep-rename
      - sls: bitcurator.config.shims
{% endfor %}
