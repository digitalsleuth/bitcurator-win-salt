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
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('mediainfo-cli') %}

include:
  - bitcurator.config.shims

mediainfo-cli-download:
  file.managed:
    - name: 'C:\salt\tempdownload\MediaInfo_CLI_{{ version }}_Windows_x64.zip'
    - source: https://mediaarea.net/download/binary/mediainfo/{{ version }}/MediaInfo_CLI_{{ version }}_Windows_x64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

mediainfo-cli-extract:
  archive.extracted:
    - name: '{{ inpath }}\mediainfo'
    - source: 'C:\salt\tempdownload\MediaInfo_CLI_{{ version }}_Windows_x64.zip'
    - enforce_toplevel: False
    - overwrite: True
    - require:
      - file: mediainfo-cli-download

mediainfo-cli-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\mediainfo\MediaInfo.exe -OutPath {{ inpath }}\shims\mediainfo.exe'
    - require:
      - archive: mediainfo-cli-extract
      - sls: bitcurator.config.shims
