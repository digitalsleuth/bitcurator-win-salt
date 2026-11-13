# Name: ExifTool
# Website: https://exiftool.org
# Description: Tool for analysing EXIF data from files
# Category: Documents / Editors
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Version: 13.63
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exiftool_path = downloads ~ '\\exiftool' %}
{% set version = salt['cmd.powershell']('Get-ChildItem -Path \'' ~ exiftool_path ~ '\' -Filter \'exiftool-*.zip\' | ForEach-Object { [PSCustomObject]@{ File = $_; Version = [version]($_.BaseName -replace \'^exiftool-([0-9.]+).*$\', \'$1\') } } | Sort-Object Version | Select-Object -Last 1 -ExpandProperty Version | ForEach-Object { $_.ToString() }').strip() %}
{% set pkg = 'exiftool-'~ version ~'.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\exiftool\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

exiftool-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: '{{ downloads }}\exiftool\{{ pkg }}'
    - enforce_toplevel: False

exiftool-folder-rename-offline:
  file.rename:
    - name: '{{ inpath }}\exiftool'
    - source: '{{ inpath }}\exiftool-{{ version }}_64'
    - force: True
    - require:
      - archive: exiftool-extract-offline

exiftool-rename-offline:
  file.rename:
    - name: '{{ inpath }}\exiftool\exiftool.exe'
    - source: '{{ inpath }}\exiftool\exiftool(-k).exe'
    - force: True
    - require:
      - archive: exiftool-extract-offline
      - file: exiftool-folder-rename-offline

exiftool-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\exiftool\exiftool.exe -OutPath {{ inpath }}\shims\exiftool.exe'
    - require:
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
