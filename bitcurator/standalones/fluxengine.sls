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
{% set hash = '3a946507df41852f58e18928ae57b40d471da8071ace7b14b90088279239041d' %}

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
