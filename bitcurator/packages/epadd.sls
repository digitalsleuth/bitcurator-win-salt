# Name: epadd
# Website: https://www.epaddproject.org/
# Description: 
# Category: Archival
# Author: Stanford University's Special Collections and University Archives
# License: Creative Commons Attribution 2.0 / Apache License v2.0 (https://github.com/ePADD/epadd/blob/main/README.md)
# Version: 11.0.2
# Notes: Will prompt for firewall access on first launch

{% set version = '11.0.2' %}
{% set hash = 'f72cb3bfbe6cd2f897171496ffbb7f84fefd9d3dc5b891ac5ff76cf9fed44b6a' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - bitcurator.repos

epadd-download:
  file.managed:
    - name: '{{ inpath }}\epadd\epadd.exe'
    - source: https://github.com/ePADD/epadd/releases/download/v{{ version }}/epadd.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

epadd-jdk-install:
  pkg.installed:
    - name: openjdk-adoptium
    - require:
      - sls: bitcurator.repos

epadd-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\ePADD.lnk'
    - target: '{{ inpath }}\epadd\epadd.exe'
    - force: True
    - working_dir: '{{ inpath }}\epadd\'
    - makedirs: True
    - require:
      - file: epadd-download
      - pkg: epadd-jdk-install
