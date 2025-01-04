# Name: exact-audio-copy
# Website: https://www.exactaudiocopy.de/
# Description: 
# Category: Archival
# Author: Andre Wiethoff
# License: Free for private use (https://www.exactaudiocopy.de/en/index.php/resources/registration/)
# Version: 1.8
# Notes: 

{% set version = '1.8' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '205530cfbfdff82343858f38b0e709e586051fb8900ecd513d7992a3c1ef031b' %}

exact-audio-copy-download-only:
  file.managed:
    - name: '{{ downloads }}\exact-audio-copy\eac-{{ version }}.exe'
    - source: https://www.exactaudiocopy.de/eac-{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
