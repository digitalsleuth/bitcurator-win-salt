# Name: advanced-renamer
# Website: https://www.advancedrenamer.com/
# Description: 
# Category: Archival
# Author: Kim Jensen (https://www.advancedrenamer.com/about)
# License: https://advancedrenamer.com/license
# Version: 4.28
# Notes: 

{% set version = '4.28' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('advanced-renamer') %}

advanced-renamer-download-only:
  file.managed:
    - name: '{{ downloads }}\advanced-renamer\advanced_renamer_setup_{{ version }}.exe'
    - source: https://www.advancedrenamer.com/down/win/advanced_renamer_setup_{{ version | replace(".", "_") }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
