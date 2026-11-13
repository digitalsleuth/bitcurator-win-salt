# Name: mediainfo
# Website: https://mediaarea.net/en/MediaInfo/Download/Windows
# Description: Tool to display and manage metadata for media files
# Category: Archival
# Author: MediaArea
# License: Open Source / BSD-style (https://mediaarea.net/en/MediaInfo)
# Version: 24.12
# Notes: 

{% set version = '24.12' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'MediaInfo_GUI_' ~ version ~ '_Windows.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\mediainfo\\' + pkg) %}

{% if exists %}

mediainfo-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\mediainfo\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\mediainfo\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
