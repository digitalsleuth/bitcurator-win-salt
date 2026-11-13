# Name: hashdeep
# Website: https://github.com/jessek/hashdeep
# Description: 
# Category: Archival
# Author: Jesse Kornblum
# License: GNU General Public License v2 (https://github.com/jessek/hashdeep/blob/master/COPYING)
# Version: 4.4
# Notes: 

# renovate: datasource=github-releases depName=jessek/hashdeep
{% set version = '4.4' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'md5deep-' ~ version ~ '.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\hashdeep\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

hashdeep-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: '{{ downloads }}\hashdeep\{{ pkg }}'
    - enforce_toplevel: False

hashdeep-rename-offline:
  file.rename:
    - name: '{{ inpath }}\hashdeep'
    - source: '{{ inpath }}\md5deep-{{ version }}'
    - force: True
    - require:
      - archive: hashdeep-extract-offline

{% for exe in ['hashdeep', 'md5deep', 'sha1deep', 'sha256deep', 'tigerdeep', 'whirlpooldeep'] %}
{{ exe }}-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\hashdeep\{{ exe }}64.exe -OutPath {{ inpath }}\shims\{{ exe }}.exe'
    - require:
      - file: hashdeep-rename-offline
      - sls: bitcurator.config.shims
{% endfor %}

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
