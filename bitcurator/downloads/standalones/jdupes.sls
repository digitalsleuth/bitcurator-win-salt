# Name: jdupes
# Website: https://codeberg.org/jbruchon/jdupes
# Description: File de-duplication software
# Category: Archival
# Author: Jody Bruchon
# License: MIT License (https://codeberg.org/jbruchon/jdupes/src/branch/master/LICENSE.txt)
# Version: 1.31.3
# Notes: 

{% set version = '1.31.3' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('jdupes') %}

jdupes-download-only:
  file.managed:
    - name: '{{ downloads }}\jdupes\jdupes-{{ version }}-win64.zip'
    - source: https://codeberg.org/jbruchon/jdupes/releases/download/v{{ version }}/jdupes-{{ version }}-win64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
