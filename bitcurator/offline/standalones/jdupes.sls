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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'jdupes-' ~ version ~ '-win64.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\jdupes\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

jdupes-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: '{{ downloads }}\jdupes\{{ pkg }}'
    - enforce_toplevel: False

jdupes-rename-offline:
  file.rename:
    - name: '{{ inpath }}\jdupes'
    - source: '{{ inpath }}\jdupes-{{ version }}-win64'
    - force: True
    - require:
      - archive: jdupes-extract-offline

jdupes-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\jdupes\jdupes.exe -OutPath {{ inpath }}\shims\jdupes.exe'
    - require:
      - file: jdupes-rename-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
