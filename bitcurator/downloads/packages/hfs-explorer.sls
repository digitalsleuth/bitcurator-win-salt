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
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('hfs-explorer') %}

hfs-explorer-download-only:
  file.managed:
    - name: '{{ downloads }}\hfs-explorer\hfs-explorer-{{ version }}-setup.exe'
    - source: https://github.com/unsound/hfsexplorer/releases/download/hfsexplorer-{{ version }}/hfsexplorer-{{ version }}-setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
