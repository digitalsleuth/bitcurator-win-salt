# Name: tika
# Website: https://tika.apache.org/download.html
# Description: Content analysis toolkit to extract metadata and text
# Category: Archival
# Author: Apache
# License: Apache License v2.0 (https://tika.apache.org/download.html)
# Version: 3.2.1
# Notes: 

{% set version = '3.2.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('tika') %}

tika-app-download-only:
  file.managed:
    - name: '{{ downloads }}\tika\tika-app-{{ version }}.jar'
    - source: https://archive.apache.org/dist/tika/{{ version }}/tika-app-{{ version }}.jar
    - source_hash: sha256={{ hash }}
    - makedirs: True
