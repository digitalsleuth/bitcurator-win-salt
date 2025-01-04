# Name: ExifTool
# Website: https://exiftool.org
# Description: Tool for analysing EXIF data from files
# Category: Archival
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Version: 12.89
# Notes:

{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set version = '12.89' %}
{% set hash = '344dd534c5cfcb46658151774a0762eff59501f84a26057a68dd48019bed789e' %}

exiftool-download-only:
  file.managed:
    - name: '{{ downloads }}\exiftool\exiftool-{{ version }}_64.zip'
    - source: https://exiftool.org/exiftool-{{ version }}_64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
