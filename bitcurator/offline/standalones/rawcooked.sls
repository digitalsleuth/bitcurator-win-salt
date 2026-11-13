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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'RAWcooked_CLI_' ~ version ~ '_Windows_x64.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\rawcooked\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.standalones.ffmpeg
  - bitcurator.config.shims

rawcooked-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\rawcooked'
    - source: '{{ downloads }}\rawcooked\{{ pkg }}'
    - enforce_toplevel: False
    - overwrite: True

rawcooked-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\rawcooked\RAWcooked.exe -OutPath {{ inpath }}\shims\rawcooked.exe'
    - require:
      - archive: rawcooked-extract-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
