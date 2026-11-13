# Name: siegfried
# Website: https://www.itforarchivists.com/siegfried/
# Description: Signature-based file format identification tool
# Category: Archival
# Author: Richard Lehane
# License: Apache License (https://github.com/richardlehane/siegfried/blob/main/LICENSE.txt)
# Version: 1.11.1
# Notes: sf.exe, roy.exe

{% set version = '1.11.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('siegfried') %}

siegfried-download-only:
  file.managed:
    - name: '{{ downloads }}\siegfried\siegfried_{{ version | replace(".","-") }}_win64.zip'
    - source: 'https://github.com/richardlehane/siegfried/releases/download/v{{ version }}/siegfried_{{ version | replace(".","-") }}_win64.zip'
    - source_hash: sha256={{ hash }}
    - makedirs: True
