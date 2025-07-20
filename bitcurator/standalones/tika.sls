# Name: tika
# Website: https://tika.apache.org/download.html
# Description: Content analysis toolkit to extract metadata and text
# Category: Archival
# Author: Apache
# License: Apache License v2.0 (https://tika.apache.org/download.html)
# Version: 3.2.1
# Notes: 

{% set version = '3.2.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = '268512b774a7a30e26ac1d6e3e5f7982cf6203a9822d4563be37b1922365d108' %}

tika-app-download:
  file.managed:
    - name: '{{ inpath }}\tika\tika-app.jar'
    - source: https://archive.apache.org/dist/tika/{{ version }}/tika-app-{{ version }}.jar
    - source_hash: sha256={{ hash }}
    - makedirs: True

tika-app-wrapper:
  file.managed:
    - name: '{{ inpath }}\tika\tika-app.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'java -jar "{{ inpath }}\tika\tika-app.jar" %*'
    - require:
      - file: tika-app-download

tika-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\tika\'
    - require:
      - file: tika-app-wrapper
