# Name: karens-directory-printer
# Website: https://www.karenware.com/powertools/karens-directory-printer
# Description: 
# Category: Archival
# Author: Karen Kenworth, Joe Winett
# License: Free for Personal and Educational Use (https://www.karenware.com/licenseme)
# Version: 5.4.4
# Notes: 

{% set version = '5.4.4' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('karens-directory-printer') %}

karens-directory-printer-download-only:
  file.managed:
    - name: '{{ downloads }}\karens-directory-printer\Karens-Directory-Printer-v{{ version }}-Setup.exe'
    - source: https://www.karenware.com/d/Karens-Directory-Printer-v{{ version }}-Setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
