# Name: jdupes
# Website: https://codeberg.org/jbruchon/jdupes
# Description: File de-duplication software
# Category: Archival
# Author: Jody Bruchon
# License: MIT License (https://codeberg.org/jbruchon/jdupes/src/branch/master/LICENSE.txt)
# Version: 1.28.0
# Notes: 

{% set version = '1.28.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'e212e9ddb5054809841af3bf5cf162fe520076a96665041d1a0843170aa27f32' %}

jdupes-download-only:
  file.managed:
    - name: '{{ downloads }}\jdupes\jdupes-{{ version }}-win64.zip'
    - source: https://codeberg.org/jbruchon/jdupes/releases/download/v{{ version }}/jdupes-{{ version }}-win64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
