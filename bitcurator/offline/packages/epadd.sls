# Name: epadd
# Website: https://www.epaddproject.org/
# Description:
# Category: Archival
# Author: Stanford University's Special Collections and University Archives
# License: Creative Commons Attribution 2.0 / Apache License v2.0 (https://github.com/ePADD/epadd/blob/main/README.md)
# Version: 11.0.2
# Notes: Will prompt for firewall access on first launch

# renovate: datasource=github-releases depName=ePADD/epadd
{% set version = '11.0.2' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set pkg = 'epadd-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\epadd\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.openjdk-adoptium

epadd-offline:
  file.managed:
    - name: '{{ inpath }}\epadd\epadd.exe'
    - source: '{{ downloads }}\epadd\{{ pkg }}'
    - skip_verify: True
    - makedirs: True

epadd-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\ePADD.lnk'
    - target: '{{ inpath }}\epadd\epadd.exe'
    - force: True
    - working_dir: '{{ inpath }}\epadd\'
    - makedirs: True
    - require:
      - file: epadd-offline
      - sls: bitcurator.offline.packages.openjdk-adoptium

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
