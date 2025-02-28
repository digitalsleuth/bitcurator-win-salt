# Name: ExifTool
# Website: https://exiftool.org
# Description: Tool for analysing EXIF data from files
# Category: Archival
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Version: 12.90
# Notes:

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '12.90' %}
{% set hash = 'd217e0ae8bdd8734be654ab9d50c863ca6ede72a20ad9e4c9fe244da58f1e269' %}

exiftool-download:
  file.managed:
    - name: 'C:\salt\tempdownload\exiftool-{{ version }}_64.zip'
    - source: https://exiftool.org/exiftool-{{ version }}_64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

exiftool-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\exiftool-{{ version }}_64.zip'
    - enforce_toplevel: False
    - watch:
      - file: exiftool-download

exiftool-folder-rename:
  file.rename:
    - name: '{{ inpath }}\exiftool'
    - source: '{{ inpath }}\exiftool-{{ version }}_64'
    - force: True
    - require:
      - archive: exiftool-extract

exiftool-rename:
  file.rename:
    - name: '{{ inpath }}\exiftool\exiftool.exe'
    - source: '{{ inpath }}\exiftool\exiftool(-k).exe'
    - force: True
    - require:
      - archive: exiftool-extract
      - file: exiftool-folder-rename

exiftool-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\exiftool\'
    - require:
      - file: exiftool-rename
