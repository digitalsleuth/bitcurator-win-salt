# Name: tika
# Website: https://tika.apache.org/download.html
# Description: Content analysis toolkit to extract metadata and text
# Category: Archival
# Author: Apache
# License: Apache License v2.0 (https://tika.apache.org/download.html)
# Version: 3.0.0
# Notes: 

{% set version = '3.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = 'f2c156533fac004d3d30d322555bb1f2581a104558a913bfc74d8c48dcf4541c' %}

tika-app-download:
  file.managed:
    - name: '{{ inpath }}\tika\tika-app.jar'
    - source: https://dlcdn.apache.org/tika/{{ version }}/tika-app-{{ version }}.jar
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
