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
{% set hash = '8ff6c5bf27d9454d6515513b4de9b9d813510f2291fa8ab4c4d82e7456bc7c4d' %}

fluxengine-download-only:
  file.managed:
    - name: '{{ downloads }}\fluxengine\fluxengine-installer-{{ version }}.exe'
    - source: https://github.com/davidgiven/fluxengine/releases/download/dev/fluxengine-installer.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
