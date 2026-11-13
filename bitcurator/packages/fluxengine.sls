# Name: fluxengine
# Website: https://github.com/davidgiven/fluxengine
# Description: PSOC5 floppy disk imaging interface
# Category: Archival
# Author: David Given
# License: MIT License (https://github.com/davidgiven/fluxengine/blob/master/COPYING.md)
# Version: 26.10.35640
# Notes: Installs for current user

{% set version = '26.10.35640' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('fluxengine') %}
{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}

fluxengine:
  pkg.installed

fluxengine-del-shortcut:
  file.absent:
    - name: 'C:\Users\{{ user }}\Desktop\FluxEngine.lnk'
    - require:
      - pkg: fluxengine
