# Name: epadd
# Website: https://www.epaddproject.org/
# Description: 
# Category: Archival
# Author: Stanford University's Special Collections and University Archives
# License: Creative Commons Attribution 2.0 / Apache License v2.0 (https://github.com/ePADD/epadd/blob/main/README.md)
# Version: 11.0.2
# Notes: Will prompt for firewall access on first launch

{% set version = '11.0.2' %}
{% set hash = 'f72cb3bfbe6cd2f897171496ffbb7f84fefd9d3dc5b891ac5ff76cf9fed44b6a' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

epadd-download-only:
  file.managed:
    - name: '{{ downloads }}\epadd\epadd-{{ version }}.exe'
    - source: https://github.com/ePADD/epadd/releases/download/v{{ version }}/epadd.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
