# Name: FilelistCreator
# Website: https://www.sttmedia.com/filelistcreator
# Description: 
# Category: Archival
# Author: Stefan Trost
# License: Custom - https://www.sttmedia.com/licence
# Version: 24.8.29
# Notes:

{% set version = '24.8.29' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'FilelistCreatorWin64-' ~ version ~ '.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\filelistcreator\\' + pkg) %}

{% if exists %}

filelistcreator-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\filelistcreator\'
    - source: '{{ downloads }}\filelistcreator\{{ pkg }}'
    - enforce_toplevel: False

filelistcreator-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\FilelistCreator.lnk'
    - target: '{{ inpath }}\filelistcreator\FilelistCreator.exe'
    - force: True
    - working_dir: '{{ inpath }}\filelistcreator\'
    - makedirs: True
    - require:
      - archive: filelistcreator-extract-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
