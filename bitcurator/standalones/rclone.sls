# Name: rclone
# Website: https://rclone.org/downloads/
# Description: Command-line program to manage files on cloud storage
# Category: Archival
# Author: Maintainers (https://github.com/rclone/rclone/blob/master/MAINTAINERS.md)
# License: MIT License (https://github.com/rclone/rclone/blob/master/COPYING)
# Version: 1.68.2
# Notes: 

{% set version = '1.68.2' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = '812bf76cc02c04cf6327f3683f3d5a88e47d36c39db84c1a745777496be7d993' %}

rclone-download:
  file.managed:
    - name: 'C:\salt\tempdownload\rclone-v{{ version }}-windows-amd64.zip'
    - source: https://github.com/rclone/rclone/releases/download/v{{ version }}/rclone-v{{ version }}-windows-amd64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

rclone-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\rclone-v{{ version }}-windows-amd64.zip'
    - enforce_toplevel: True
    - overwrite: True
    - require:
      - file: rclone-download

rclone-rename:
  file.rename:
    - name: '{{ inpath }}\rclone'
    - source: '{{ inpath }}\rclone-v{{ version }}-windows-amd64'
    - force: True
    - require:
      - archive: rclone-extract

rclone-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\rclone'
    - require:
      - file: rclone-rename
