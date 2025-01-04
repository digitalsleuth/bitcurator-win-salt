# Name: hashmyfiles
# Website: https://www.nirsoft.net/utils/hash_my_files.html
# Description: 
# Category: Archival
# Author: Nir Softer
# License: Freeware (https://www.nirsoft.net/utils/hash_my_files.html)
# Version: 2.5.0
# Notes: 

{% set version = '2.5.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '38ead72bb0df274156e14f7e3a258021c5dff0a345cb63f6447da581d585c8ee' %}

hashmyfiles-download-only:
  file.managed:
    - name: '{{ downloads }}\hashmyfiles\hashmyfiles-x64-{{ version }}.zip'
    - source: https://www.nirsoft.net/utils/hashmyfiles-x64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
