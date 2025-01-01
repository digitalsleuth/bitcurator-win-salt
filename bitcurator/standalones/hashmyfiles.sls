# Name: hashmyfiles
# Website: https://www.nirsoft.net/utils/hash_my_files.html
# Description: 
# Category: Archival
# Author: Nir Softer
# License: Freeware (https://www.nirsoft.net/utils/hash_my_files.html)
# Version: 2.5.0
# Notes: 

{% set version = '2.5.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set hash = '38ead72bb0df274156e14f7e3a258021c5dff0a345cb63f6447da581d585c8ee' %}

hashmyfiles-download:
  file.managed:
    - name: 'C:\salt\tempdownload\hashmyfiles-x64.zip'
    - source: https://www.nirsoft.net/utils/hashmyfiles-x64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

hashmyfiles-extract:
  archive.extracted:
    - name: '{{ inpath }}\hashmyfiles\'
    - source: 'C:\salt\tempdownload\hashmyfiles-x64.zip'
    - enforce_toplevel: False
    - require:
      - file: hashmyfiles-download

hashmyfiles-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\HashMyFiles.lnk'
    - target: {{ inpath }}\hashmyfiles\HashMyFiles.exe
    - force: True
    - working_dir: {{ inpath }}\hashmyfiles\
    - makedirs: True
    - require:
      - archive: hashmyfiles-extract
