# Name: mediainfo
# Website: https://mediaarea.net/en/MediaInfo/Download/Windows
# Description: Tool to display and manage metadata for media files
# Category: Archival
# Author: MediaArea
# License: Open Source / BSD-style (https://mediaarea.net/en/MediaInfo)
# Version: 24.12
# Notes: 

{% set version = '24.12' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '7de8c5d7b7654acceb54aa4484014c6fa0d470cdc5a2130e6dfb7b2e2aa15f8f' %}

mediainfo-download-only:
  file.managed:
    - name: '{{ downloads }}\mediainfo\MediaInfo_GUI_{{ version }}_Windows.exe'
    - source: https://mediaarea.net/download/binary/mediainfo-gui/{{ version }}/MediaInfo_GUI_{{ version }}_Windows.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
