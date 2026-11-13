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
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('hashmyfiles') %}

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
