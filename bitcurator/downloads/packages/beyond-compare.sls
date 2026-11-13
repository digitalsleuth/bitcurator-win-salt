# Name: beyondcompare
# Website: https://www.scootersoftware.com/
# Description: Software to compare, merge, and synchronize data
# Category: Archival
# Author: Scooter Software (https://www.scootersoftware.com/about)
# License: Free Trial - Additional Licensing (https://www.scootersoftware.com/kb/licensev5)
# Version: 5.0.4
# Notes: 

{% set version = '5.0.4' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set subver = get_hash('beyond-compare', 'subver') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set hash = get_hash('beyond-compare') %}

beyond-compare-download-only:
  file.managed:
    - name: '{{ downloads }}\beyond-compare\BCompare-{{ version }}.{{ subver }}.exe'
    - source: https://www.scootersoftware.com/files/BCompare-{{ version }}.{{ subver }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
