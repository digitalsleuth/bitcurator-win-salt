# Name: rclone
# Website: https://rclone.org/downloads/
# Description: Command-line program to manage files on cloud storage
# Category: Archival
# Author: Maintainers (https://github.com/rclone/rclone/blob/master/MAINTAINERS.md)
# License: MIT License (https://github.com/rclone/rclone/blob/master/COPYING)
# Version: 1.68.2
# Notes: 

{% set version = '1.68.2' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('rclone') %}

rclone-download-only:
  file.managed:
    - name: '{{ downloads }}\rclone\rclone-v{{ version }}-windows-amd64.zip'
    - source: https://github.com/rclone/rclone/releases/download/v{{ version }}/rclone-v{{ version }}-windows-amd64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
