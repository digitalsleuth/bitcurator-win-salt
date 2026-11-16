# Name: dart
# Website: https://aptrust.github.io/dart-docs/
# Description: Digital Archivist's Resource Tool
# Category: Archival
# Author: Academic Preservation Trust
# License: BSD 2-Clause License (https://github.com/APTrust/dart/blob/master/LICENSE)
# Version: 3.0.1
# Notes: dart

{% set version = '3.0.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set pkg = 'dart-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\dart\\' + pkg) %}

{% if exists %}

dart-rename-offline:
  file.rename:
    - name: '{{ inpath }}\dart'
    - source: '{{ downloads }}\dart\'
    - force: True
    - makedirs: True

dart-rename-exe-offline:
  file.rename:
    - name: '{{ inpath }}\dart\dart.exe'
    - source: '{{ inpath }}\dart\dart-{{ version }}.exe'
    - force: True
    - makedirs: True
    - require:
      - file: dart-rename-offline

dart-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\DART.lnk'
    - target: {{ inpath }}\dart\dart.exe
    - force: True
    - working_dir: {{ inpath }}\dart\
    - makedirs: True
    - require:
      - file: dart-rename-offline
      - file: dart-rename-exe-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}

