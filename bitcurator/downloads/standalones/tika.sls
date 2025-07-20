# Name: tika
# Website: https://tika.apache.org/download.html
# Description: Content analysis toolkit to extract metadata and text
# Category: Archival
# Author: Apache
# License: Apache License v2.0 (https://tika.apache.org/download.html)
# Version: 3.2.1
# Notes: 

{% set version = '3.2.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '268512b774a7a30e26ac1d6e3e5f7982cf6203a9822d4563be37b1922365d108' %}

tika-app-download-only:
  file.managed:
    - name: '{{ downloads }}\tika\tika-app-{{ version }}.jar'
    - source: https://archive.apache.org/dist/tika/{{ version }}/tika-app-{{ version }}.jar
    - source_hash: sha256={{ hash }}
    - makedirs: True
