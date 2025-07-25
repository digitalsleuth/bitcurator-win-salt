# Name: ExifTool
# Website: https://exiftool.org
# Description: Tool for analysing EXIF data from files
# Category: Archival
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Version: 13.32
# Notes:

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '13.32' %}
{% set hash = '1c1863883d543db4b95a0e4fa52bbfd0be9e996ae6b411aad2af5f1787912a2e' %}

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
