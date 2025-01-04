# Name: karens-directory-printer
# Website: https://www.karenware.com/powertools/karens-directory-printer
# Description: 
# Category: Archival
# Author: Karen Kenworth, Joe Winett
# License: Free for Personal and Educational Use (https://www.karenware.com/licenseme)
# Version: 5.4.4
# Notes: 

{% set version = '5.4.4' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'd4ee3c6b1e12e72854022bb360ece5a7574b9cd3afc4024fe62b369db9920e7f' %}

karens-directory-printer-download-only:
  file.managed:
    - name: '{{ downloads }}\karens-directory-printer\Karens-Directory-Printer-v{{ version }}-Setup.exe'
    - source: https://www.karenware.com/d/Karens-Directory-Printer-v{{ version }}-Setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
