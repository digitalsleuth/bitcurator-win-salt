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
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('tika') %}

include:
  - bitcurator.config.shims

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

tika-app-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\tika\tika-app.cmd -OutPath {{ inpath }}\shims\tika-app.exe'
    - require:
      - file: tika-app-wrapper
      - sls: bitcurator.config.shims
