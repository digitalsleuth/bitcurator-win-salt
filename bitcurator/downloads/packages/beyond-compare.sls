# Name: beyondcompare
# Website: https://www.scootersoftware.com/
# Description: Software to compare, merge, and synchronize data
# Category: Archival
# Author: Scooter Software (https://www.scootersoftware.com/about)
# License: Free Trial - Additional Licensing (https://www.scootersoftware.com/kb/licensev5)
# Version: 5.0.4
# Notes: 

{% set version = '5.0.4' %}
{% set subver = '30422' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'd74892601a50514b5636e27d4be4d3ac38597f2f6c7c7b6b5b169a48ffa1f341' %}

beyond-compare-download-only:
  file.managed:
    - name: '{{ downloads }}\beyond-compare\BCompare-{{ version }}.{{ subver }}.exe'
    - source: https://www.scootersoftware.com/files/BCompare-{{ version }}.{{ subver }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
