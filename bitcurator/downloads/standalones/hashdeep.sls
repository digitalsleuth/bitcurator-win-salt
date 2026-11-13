# Name: hashdeep
# Website: https://github.com/jessek/hashdeep
# Description: 
# Category: Archival
# Author: Jesse Kornblum
# License: GNU General Public License v2 (https://github.com/jessek/hashdeep/blob/master/COPYING)
# Version: 4.4
# Notes: 

{% set version = '4.4' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('hashdeep') %}

hashdeep-download-only:
  file.managed:
    - name: '{{ downloads }}\hashdeep\md5deep-{{ version }}.zip'
    - source: https://github.com/jessek/hashdeep/releases/download/v{{ version }}/md5deep-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
