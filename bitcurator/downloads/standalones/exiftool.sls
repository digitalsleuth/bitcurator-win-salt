# Name: ExifTool
# Website: https://exiftool.org
# Description: Tool for analysing EXIF data from files
# Category: Archival
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Version: 13.32
# Notes:

{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set version = '13.32' %}
{% set hash = '1c1863883d543db4b95a0e4fa52bbfd0be9e996ae6b411aad2af5f1787912a2e' %}

exiftool-download-only:
  file.managed:
    - name: '{{ downloads }}\exiftool\exiftool-{{ version }}_64.zip'
    - source: https://exiftool.org/exiftool-{{ version }}_64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
