# Name: jhove
# Website: https://jhove.openpreservation.org/
# Description: JSTOR/Harvard Object Validation Environment - File validation and characterisation
# Category: Archival
# Author: Open Preservation Foundation
# License: GNU Lesser Public License v2.1 (https://github.com/openpreserve/jhove/blob/integration/LICENSE)
# Version: 1.32.0
# Notes: Packaged separately for silent unattended installation

{% set version = '1.32.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'jhove-' ~ version ~ '.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\jhove\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.openjdk-adoptium
  - bitcurator.config.shims

jhove-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: '{{ downloads }}\jhove\{{ pkg }}'
    - enforce_toplevel: True

jhove-config-offline:
  file.replace:
    - name: '{{ inpath }}\jhove\conf\jhove.conf'
    - pattern: PLACEHOLDER_PATH
    - repl: {{ inpath | regex_escape }}
    - count: 1
    - require:
      - archive: jhove-extract-offline
      - sls: bitcurator.offline.packages.openjdk-adoptium

jhove-gui-icon-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\jhove.lnk'
    - target: '{{ inpath }}\jhove\jhove-gui.bat'
    - icon_location: '{{ inpath }}\jhove\jhove.ico'
    - force: True
    - working_dir: '{{ inpath }}\jhove\'
    - makedirs: True
    - require:
      - file: jhove-config-offline

jhove-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\jhove\jhove.bat -OutPath {{ inpath }}\shims\jhove.exe'
    - require:
      - file: jhove-config-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
