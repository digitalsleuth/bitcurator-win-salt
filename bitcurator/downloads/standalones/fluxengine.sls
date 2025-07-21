# Name: fluxengine
# Website: https://github.com/davidgiven/fluxengine
# Description: PSOC5 floppy disk imaging interface
# Category: Archival
# Author: David Given
# License: MIT License (https://github.com/davidgiven/fluxengine/blob/master/COPYING.md)
# Version: None
# Notes: Installs for current user

{% set version = '0.0.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '65b11b8ac51b6113d569bc619fa7b400738a35295ce5bd287b8c476f8f9f02f0' %}

fluxengine-download-only:
  file.managed:
    - name: '{{ downloads }}\fluxengine\fluxengine-installer-{{ version }}.exe'
    - source: https://github.com/davidgiven/fluxengine/releases/download/dev/fluxengine-installer.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
