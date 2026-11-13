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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'tika-app-' ~ version ~ '.jar' %}
{% set exists = salt['file.file_exists'](downloads + '\\tika\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

tika-app-offline:
  file.managed:
    - name: '{{ inpath }}\tika\tika-app.jar'
    - source: '{{ downloads }}\tika\{{ pkg }}'
    - skip_verify: True
    - makedirs: True

tika-app-wrapper-offline:
  file.managed:
    - name: '{{ inpath }}\tika\tika-app.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'java -jar "{{ inpath }}\tika\tika-app.jar" %*'

tika-app-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\tika\tika-app.cmd -OutPath {{ inpath }}\shims\tika-app.exe'
    - require:
      - file: tika-app-wrapper-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
