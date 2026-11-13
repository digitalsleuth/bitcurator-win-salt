# Name: hashmyfiles
# Website: https://www.nirsoft.net/utils/hash_my_files.html
# Description: 
# Category: Archival
# Author: Nir Softer
# License: Freeware (https://www.nirsoft.net/utils/hash_my_files.html)
# Version: 2.52
# Notes: 

{% set version = '2.52' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'hashmyfiles-x64-' ~ version ~ '.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\hashmyfiles\\' + pkg) %}

{% if exists %}

hashmyfiles-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\hashmyfiles\'
    - source: '{{ downloads }}\hashmyfiles\{{ pkg }}'
    - enforce_toplevel: False

hashmyfiles-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\HashMyFiles.lnk'
    - target: {{ inpath }}\hashmyfiles\HashMyFiles.exe
    - force: True
    - working_dir: {{ inpath }}\hashmyfiles\
    - makedirs: True
    - require:
      - archive: hashmyfiles-extract-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
