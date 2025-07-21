# Name: fluxengine
# Website: https://github.com/davidgiven/fluxengine
# Description: PSOC5 floppy disk imaging interface
# Category: Archival
# Author: David Given
# License: MIT License (https://github.com/davidgiven/fluxengine/blob/master/COPYING.md)
# Version: None
# Notes: Installs for current user

{% set version = '0.0.0' %}
{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% set hash = '65b11b8ac51b6113d569bc619fa7b400738a35295ce5bd287b8c476f8f9f02f0' %}

fluxengine-download:
  file.managed:
    - name: 'C:\salt\tempdownload\fluxengine-installer.exe'
    - source: https://github.com/davidgiven/fluxengine/releases/download/dev/fluxengine-installer.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

fluxengine-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\fluxengine-installer.exe /S'
    - shell: cmd
    - require:
      - file: fluxengine-download

fluxengine-del-shortcut:
  file.absent:
    - name: 'C:\Users\{{ user }}\Desktop\FluxEngine.lnk'
    - require:
      - cmd: fluxengine-install
      - user: user-{{ user }}
