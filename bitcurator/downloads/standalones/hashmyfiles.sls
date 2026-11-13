# Name: hashmyfiles
# Website: https://www.nirsoft.net/utils/hash_my_files.html
# Description: 
# Category: Archival
# Author: Nir Softer
# License: Freeware (https://www.nirsoft.net/utils/hash_my_files.html)
# Version: 2.52
# Notes: 

{% set version = '2.52' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('hashmyfiles') %}

hashmyfiles-download-only:
  file.managed:
    - name: '{{ downloads }}\hashmyfiles\hashmyfiles-x64-{{ version }}.zip'
    - source: https://www.nirsoft.net/utils/hashmyfiles-x64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
