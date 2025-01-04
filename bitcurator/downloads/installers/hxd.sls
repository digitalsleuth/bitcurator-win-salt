# Name: HxD 
# Website: https://mh-nexus.de
# Description: Hex Editor
# Category: Archival
# Author: Mael Horz
# License: https://mh-nexus.de/en/about.php
# Version: 2.5.0.0
# Notes:

{% set version = '2.5.0.0' %}
{% set hash = '5065041c7b03c24b9533a5b32b33db58f2b4924cd84bed41834ff2db51c1cb7c' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

hxd-download-only:
  file.managed:
    - name: '{{ downloads }}\hxd\HxDSetup-{{ version }}.zip'
    - source: https://mh-nexus.de/downloads/HxDSetup.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
