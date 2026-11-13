# Name: mediainfo-cli
# Website: https://mediaarea.net/en/MediaInfo/Download/Windows
# Description: CLI tool to display and manage metadata for media files
# Category: Archival
# Author: MediaArea
# License: Open Source / BSD-style (https://mediaarea.net/en/MediaInfo)
# Version: 24.12
# Notes: 

{% set version = '24.12' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'MediaInfo_CLI_' ~ version ~ '_Windows_x64.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\mediainfo\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

mediainfo-cli-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\mediainfo'
    - source: '{{ downloads }}\mediainfo\{{ pkg }}'
    - enforce_toplevel: False
    - overwrite: True

mediainfo-cli-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\mediainfo\MediaInfo.exe -OutPath {{ inpath }}\shims\mediainfo.exe'
    - require:
      - archive: mediainfo-cli-extract-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
