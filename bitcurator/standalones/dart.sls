# Name: dart
# Website: https://aptrust.github.io/dart-docs/
# Description: Digital Archivist's Resource Tool
# Category: Archival
# Author: Academic Preservation Trust
# License: BSD 2-Clause License (https://github.com/APTrust/dart/blob/master/LICENSE)
# Version: 3.0.1
# Notes: dart

{% set version = '3.0.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('dart') %}

dart-download:
  file.managed:
    - name: '{{ inpath }}\dart\dart.exe'
    - source: https://s3.amazonaws.com/aptrust.public.download/dart3/v{{ version }}/windows-amd64/dart.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

dart-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\DART.lnk'
    - target: {{ inpath }}\dart\dart.exe
    - force: True
    - working_dir: {{ inpath }}\dart\
    - makedirs: True
    - require:
      - file: dart-download
