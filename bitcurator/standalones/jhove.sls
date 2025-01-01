# Name: jhove
# Website: https://jhove.openpreservation.org/
# Description: JSTOR/Harvard Object Validation Environment - File validation and characterisation
# Category: Archival
# Author: Open Preservation Foundation
# License: GNU Lesser Public License v2.1 (https://github.com/openpreserve/jhove/blob/integration/LICENSE)
# Version: 1.32.0
# Notes: Packaged separately for silent unattended installation

{% set version = '1.32.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set hash = 'ce548598ddd107a349007c5ab0f9e4c1c40ad858cd3095dc592fc9197a3cbbc4' %}

include:
  - bitcurator.packages.openjdk-adoptium

jhove-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: salt://bitcurator/files/jhove-{{ version }}.zip
    - enforce_toplevel: True

jhove-config:
  file.replace:
    - name: '{{ inpath }}\jhove\conf\jhove.conf'
    - pattern: PLACEHOLDER_PATH
    - repl: {{ inpath | regex_escape }}
    - count: 1
    - require:
      - archive: jhove-extract
      - sls: bitcurator.packages.openjdk-adoptium

jhove-gui-icon:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\jhove.lnk'
    - target: '{{ inpath }}\jhove\jhove-gui.bat'
    - icon_location: '{{ inpath }}\jhove\jhove.ico'
    - force: True
    - working_dir: '{{ inpath }}\jhove\'
    - makedirs: True
    - require:
      - file: jhove-config

jhove-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\jhove'
    - require:
      - file: jhove-config
