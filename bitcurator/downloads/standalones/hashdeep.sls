# Name: hashdeep
# Website: https://github.com/jessek/hashdeep
# Description: 
# Category: Archival
# Author: Jesse Kornblum
# License: GNU General Public License v2 (https://github.com/jessek/hashdeep/blob/master/COPYING)
# Version: 4.4
# Notes: 

{% set version = '4.4' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'd5e85933e74e5ba6a73f67346bc2e765075d26949c831a428166c92772f67dbc' %}

hashdeep-download-only:
  file.managed:
    - name: '{{ downloads }}\hashdeep\md5deep-{{ version }}.zip'
    - source: https://github.com/jessek/hashdeep/releases/download/v{{ version }}/md5deep-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
