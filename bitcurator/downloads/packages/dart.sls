# Name: dart
# Website: https://aptrust.github.io/dart-docs/
# Description: Digital Archivist's Resource Tool
# Category: Archival
# Author: Academic Preservation Trust
# License: BSD 2-Clause License (https://github.com/APTrust/dart/blob/master/LICENSE)
# Version: 2.0.22
# Notes: 

{% set version = '2.0.22' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '78f09829575c60ba86fc22f47a5d810559a3624e01baefa82a8220451c846ae0' %}

dart-download-only:
  file.managed:
    - name: '{{ downloads }}\dart\DART+Setup+{{ version }}.exe'
    - source: https://s3.amazonaws.com/aptrust.public.download/DART/DART+Setup+{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
