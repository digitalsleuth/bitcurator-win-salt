# Name: fluxengine
# Website: https://github.com/davidgiven/fluxengine
# Description: PSOC5 floppy disk imaging interface
# Category: Archival
# Author: David Given
# License: MIT License (https://github.com/davidgiven/fluxengine/blob/master/COPYING.md)
# Version: 26.10.35640
# Notes: Installs for current user

# renovate: datasource=github-releases depName=davidgiven/fluxengine
{% set version = '26.10.35640' %}
{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'fluxengine-' ~ version ~ '.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\fluxengine\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.user

fluxengine-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\fluxengine\{{ pkg }}" /qn /norestart'
    - shell: cmd

fluxengine-del-shortcut-offline:
  file.absent:
    - name: 'C:\Users\{{ user }}\Desktop\FluxEngine.lnk'
    - require:
      - cmd: fluxengine-install-offline
      - user: user-{{ user }}

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
