# Name: hfs-explorer
# Website: https://www.catacombae.org/hfsexplorer/
# Description: An application for accessing HFS/HFS+/HFSX file systems
# Category: Archival
# Author: Erik Larsson
# License: GNU General Public License v3+ (https://github.com/unsound/hfsexplorer/blob/master/doc/gpl.txt)
# Version: 2021.10.9
# Notes: 

# renovate: datasource=github-releases depName=unsound/hfsexplorer
{% set version = '2021.10.9' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'hfs-explorer-' ~ version ~ '-setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\hfs-explorer\\' + pkg) %}

{% if exists %}

hfs-explorer-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\hfs-explorer\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\hfs-explorer\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
