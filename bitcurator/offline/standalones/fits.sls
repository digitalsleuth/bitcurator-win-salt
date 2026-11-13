# Name: fits
# Website: https://github.com/harvard-lts/fits
# Description: 
# Category: Archival
# Author: Harvard University
# License: GNU Lesser General Public License v2.1 (https://github.com/harvard-lts/fits/blob/main/LICENSE)
# Version: 1.6.0
# Notes: 

# renovate: datasource=github-releases depName=harvard-lts/fits
{% set version = '1.6.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'fits-' ~ version ~ '.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\fits\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.openjdk-adoptium
  - bitcurator.config.shims

fits-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\fits\'
    - source: '{{ downloads }}\fits\{{ pkg }}'
    - enforce_toplevel: False
    - require:
      - sls: bitcurator.offline.packages.openjdk-adoptium

fits-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\fits\fits.bat -OutPath {{ inpath }}\shims\fits.exe'
    - require:
      - archive: fits-extract-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
