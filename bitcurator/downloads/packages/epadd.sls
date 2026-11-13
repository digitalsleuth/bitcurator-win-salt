# Name: epadd
# Website: https://www.epaddproject.org/
# Description: 
# Category: Archival
# Author: Stanford University's Special Collections and University Archives
# License: Creative Commons Attribution 2.0 / Apache License v2.0 (https://github.com/ePADD/epadd/blob/main/README.md)
# Version: 11.0.2
# Notes: Will prompt for firewall access on first launch

{% set version = '11.0.2' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('epadd') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

epadd-download-only:
  file.managed:
    - name: '{{ downloads }}\epadd\epadd-{{ version }}.exe'
    - source: https://github.com/ePADD/epadd/releases/download/v{{ version }}/epadd.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
