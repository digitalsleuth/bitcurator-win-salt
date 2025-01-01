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
{% set hash = 'cfe34a5345c49f1680775f4c585536e804b9a1991a3f5d983ac8f902d3682b17' %}

filelistcreator-download:
  file.managed:
    - name: 'C:\salt\tempdownload\FilelistCreatorWin64-{{ version }}.zip'
    - source: https://www.sttmedia.com/downloads/FilelistCreatorWin64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

filelistcreator-extract:
  archive.extracted:
    - name: '{{ inpath }}\filelistcreator\'
    - source: 'C:\salt\tempdownload\FilelistCreatorWin64-{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: filelistcreator-download

filelistcreator-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\FilelistCreator.lnk'
    - target: '{{ inpath }}\filelistcreator\FilelistCreator.exe'
    - force: True
    - working_dir: '{{ inpath }}\filelistcreator\'
    - makedirs: True
    - require:
      - archive: filelistcreator-extract
