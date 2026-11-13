# Name: dart
# Website: https://aptrust.github.io/dart-docs/
# Description: Digital Archivist's Resource Tool
# Category: Archival
# Author: Academic Preservation Trust
# License: BSD 2-Clause License (https://github.com/APTrust/dart/blob/master/LICENSE)
# Version: 2.0.22
# Notes: 

{% set version = '2.0.22' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('dart') %}

dart-download-only:
  file.managed:
    - name: '{{ downloads }}\dart\DART+Setup+{{ version }}.exe'
    - source: https://s3.amazonaws.com/aptrust.public.download/DART/DART+Setup+{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
