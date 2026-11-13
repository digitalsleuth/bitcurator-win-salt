# Name: exact-audio-copy
# Website: https://www.exactaudiocopy.de/
# Description: 
# Category: Archival
# Author: Andre Wiethoff
# License: Free for private use (https://www.exactaudiocopy.de/en/index.php/resources/registration/)
# Version: 1.8
# Notes: 

{% set version = '1.8' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('exact-audio-copy') %}

exact-audio-copy-download-only:
  file.managed:
    - name: '{{ downloads }}\exact-audio-copy\eac-{{ version }}.exe'
    - source: https://www.exactaudiocopy.de/eac-{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
