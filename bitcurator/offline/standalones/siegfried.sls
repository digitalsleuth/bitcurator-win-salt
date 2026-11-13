# Name: siegfried
# Website: https://www.itforarchivists.com/siegfried/
# Description: Signature-based file format identification tool
# Category: Archival
# Author: Richard Lehane
# License: Apache License (https://github.com/richardlehane/siegfried/blob/main/LICENSE.txt)
# Version: 1.11.1
# Notes: sf.exe, roy.exe

# renovate: datasource=github-releases depName=richardlehane/siegfried
{% set version = '1.11.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'siegfried_' ~ (version | replace(".","-")) ~ '_win64.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\siegfried\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

siegfried-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\siegfried\'
    - enforce_toplevel: False
    - source: '{{ downloads }}\siegfried\{{ pkg }}'
    - overwrite: True

{% for exe in ['sf', 'roy'] %}
{{ exe }}-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\siegfried\{{ exe }}.exe -OutPath {{ inpath }}\shims\{{ exe }}.exe'
    - require:
      - archive: siegfried-extract-offline
      - sls: bitcurator.config.shims
{% endfor %}

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
