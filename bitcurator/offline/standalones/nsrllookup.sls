# Name: nsrllookup
# Website: https://rjhansen.github.io/nsrllookup/
# Description: Tool to look up the hash for a file in the NSRL
# Category: Archival
# Author: Robert J. Hansen
# License: ISC License (https://github.com/rjhansen/nsrllookup/blob/master/LICENSE)
# Version: 1.4.2
# Notes: 

# renovate: datasource=github-releases depName=rjhansen/nsrllookup
{% set version = '1.4.2' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'nsrllookup-' ~ version ~ '-win64.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\nsrllookup\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

nsrllookup-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: '{{ downloads }}\nsrllookup\{{ pkg }}'
    - enforce_toplevel: True
    - overwrite: True

nsrllookup-rename-offline:
  file.rename:
    - name: '{{ inpath }}\nsrllookup'
    - source: '{{ inpath }}\nsrllookup-{{ version }}-win64'
    - force: True
    - require:
      - archive: nsrllookup-extract-offline

nsrllookup-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\nsrllookup\nsrllookup.exe -OutPath {{ inpath }}\shims\nsrllookup.exe'
    - require:
      - file: nsrllookup-rename-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
