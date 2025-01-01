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
{% set hash = 'd945767f683c05ee5100f4883eda746767cf5f59acd998f37ae2acea7cc5760f' %}

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

mediainfo-cli-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\mediainfo'
    - require:
      - archive: mediainfo-cli-extract
