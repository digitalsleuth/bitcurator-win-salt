# Name: rawcooked
# Website: https://mediaarea.net/RAWcooked
# Description: Encodes RAW audio/visual sequences into a lossless video stream
# Category: Archival
# Author: MediaArea
# License: BSD 2-Clause license (https://mediaarea.net/RAWcooked)
# Version: 24.11
# Notes: 

{% set version = '24.11' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('rawcooked') %}

rawcooked-download-only:
  file.managed:
    - name: '{{ downloads }}\rawcooked\RAWcooked_CLI_{{ version }}_Windows_x64.zip'
    - source: https://mediaarea.net/download/binary/rawcooked/{{ version }}/RAWcooked_CLI_{{ version }}_Windows_x64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
