# Name: jdupes
# Website: https://codeberg.org/jbruchon/jdupes
# Description: File de-duplication software
# Category: Archival
# Author: Jody Bruchon
# License: MIT License (https://codeberg.org/jbruchon/jdupes/src/branch/master/LICENSE.txt)
# Version: 1.31.3
# Notes: 

{% set version = '1.31.3' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('jdupes') %}

include:
  - bitcurator.config.shims

jdupes-download:
  file.managed:
    - name: 'C:\salt\tempdownload\jdupes-{{ version }}-win64.zip'
    - source: https://codeberg.org/jbruchon/jdupes/releases/download/v{{ version }}/jdupes-{{ version }}-win64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

jdupes-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\jdupes-{{ version }}-win64.zip'
    - enforce_toplevel: False
    - require:
      - file: jdupes-download

jdupes-rename:
  file.rename:
    - name: '{{ inpath }}\jdupes'
    - source: '{{ inpath }}\jdupes-{{ version }}-win64'
    - force: True
    - require:
      - archive: jdupes-extract

jdupes-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\jdupes\jdupes.exe -OutPath {{ inpath }}\shims\jdupes.exe'
    - require:
      - file: jdupes-rename
      - sls: bitcurator.config.shims
