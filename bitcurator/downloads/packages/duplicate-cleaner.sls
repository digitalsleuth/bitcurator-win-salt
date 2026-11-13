# Name: Duplicate Cleaner
# Website: https://www.duplicatecleaner.com/
# Description: Tool to identify and manage duplicate files in a file system
# Category: Archival
# Author: DigitalVolcano Software
# License: 7 Day Free Trial - License after trial
# Version: 5.28.0.0
# Notes: 

{% set version = '5.28.0.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('duplicate-cleaner') %}

duplicate-cleaner-download-only:
  file.managed:
    - name: '{{ downloads }}\duplicate-cleaner\DuplicateCleaner-Setup-{{ version.split(".")[0] }}.msi'
    - source: https://www.digitalvolcano.co.uk/download/DuplicateCleaner-Setup-{{ version.split(".")[0] }}.msi
    - source_hash: sha256={{ hash }}
    - makedirs: True
