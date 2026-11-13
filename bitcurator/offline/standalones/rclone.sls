# Name: rclone
# Website: https://rclone.org/downloads/
# Description: Command-line program to manage files on cloud storage
# Category: Archival
# Author: Maintainers (https://github.com/rclone/rclone/blob/master/MAINTAINERS.md)
# License: MIT License (https://github.com/rclone/rclone/blob/master/COPYING)
# Version: 1.68.2
# Notes: 

# renovate: datasource=github-releases depName=rclone/rclone
{% set version = '1.68.2' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'rclone-v' ~ version ~ '-windows-amd64.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\rclone\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

rclone-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: '{{ downloads }}\rclone\{{ pkg }}'
    - enforce_toplevel: True
    - overwrite: True

rclone-rename-offline:
  file.rename:
    - name: '{{ inpath }}\rclone'
    - source: '{{ inpath }}\rclone-v{{ version }}-windows-amd64'
    - force: True
    - require:
      - archive: rclone-extract-offline

rclone-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\rclone\rclone.exe -OutPath {{ inpath }}\shims\rclone.exe'
    - require:
      - file: rclone-rename-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
