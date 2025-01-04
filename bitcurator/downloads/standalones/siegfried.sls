# Name: siegfried
# Website: https://www.itforarchivists.com/siegfried/
# Description: Signature-based file format identification tool
# Category: Archival
# Author: Richard Lehane
# License: Apache License (https://github.com/richardlehane/siegfried/blob/main/LICENSE.txt)
# Version: 1.11.1
# Notes: sf.exe, roy.exe

{% set version = '1.11.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '89188357e78f4405f0c7d2b71d24668d9f9dd83ecc5df9901dd7fdc12d77b809' %}

siegfried-download-only:
  file.managed:
    - name: '{{ downloads }}\siegfried\siegfried_{{ version | replace(".","-") }}_win64.zip'
    - source: 'https://github.com/richardlehane/siegfried/releases/download/v{{ version }}/siegfried_{{ version | replace(".","-") }}_win64.zip'
    - source_hash: sha256={{ hash }}
    - makedirs: True
