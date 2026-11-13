# Name: rawcooked
# Website: https://mediaarea.net/RAWcooked
# Description: Encodes RAW audio/visual sequences into a lossless video stream
# Category: Archival
# Author: MediaArea
# License: BSD 2-Clause license (https://mediaarea.net/RAWcooked)
# Version: 24.11
# Notes: 

{% set version = '24.11' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('rawcooked') %}

include:
  - bitcurator.standalones.ffmpeg
  - bitcurator.config.shims

rawcooked-download:
  file.managed:
    - name: 'C:\salt\tempdownload\RAWcooked_CLI_{{ version }}_Windows_x64.zip'
    - source: https://mediaarea.net/download/binary/rawcooked/{{ version }}/RAWcooked_CLI_{{ version }}_Windows_x64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

rawcooked-extract:
  archive.extracted:
    - name: '{{ inpath }}\rawcooked'
    - source: 'C:\salt\tempdownload\RAWcooked_CLI_{{ version }}_Windows_x64.zip'
    - enforce_toplevel: False
    - overwrite: True
    - require:
      - file: rawcooked-download

rawcooked-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\rawcooked\RAWcooked.exe -OutPath {{ inpath }}\shims\rawcooked.exe'
    - require:
      - archive: rawcooked-extract
      - sls: bitcurator.config.shims
