# Name: Duplicate Cleaner
# Website: https://www.duplicatecleaner.com/
# Description: Tool to identify and manage duplicate files in a file system
# Category: Archival
# Author: DigitalVolcano Software
# License: 7 Day Free Trial - License after trial
# Version: 5.24.0.0
# Notes: 

{% set version = '5.24.0.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '4f5a6a95946a03fbd711ba19527e7c7002f719438939ad63333d1af12d8c28c9' %}

duplicate-cleaner-download-only:
  file.managed:
    - name: '{{ downloads }}\duplicate-cleaner\DuplicateCleaner-Setup-{{ version.split(".")[0] }}.msi'
    - source: https://www.digitalvolcano.co.uk/download/DuplicateCleaner-Setup-{{ version.split(".")[0] }}.msi
    - source_hash: sha256={{ hash }}
    - makedirs: True
