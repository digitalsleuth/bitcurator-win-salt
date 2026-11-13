# Name: mediainfo-cli
# Website: https://mediaarea.net/en/MediaInfo/Download/Windows
# Description: CLI tool to display and manage metadata for media files
# Category: Archival
# Author: MediaArea
# License: Open Source / BSD-style (https://mediaarea.net/en/MediaInfo)
# Version: 24.12
# Notes: 

{% set version = '24.12' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('mediainfo-cli') %}

mediainfo-cli-download-only:
  file.managed:
    - name: '{{ downloads }}\mediainfo\MediaInfo_CLI_{{ version }}_Windows_x64.zip'
    - source: https://mediaarea.net/download/binary/mediainfo/{{ version }}/MediaInfo_CLI_{{ version }}_Windows_x64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
