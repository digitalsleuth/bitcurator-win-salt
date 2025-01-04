# Name: hfs-explorer
# Website: https://www.catacombae.org/hfsexplorer/
# Description: An application for accessing HFS/HFS+/HFSX file systems
# Category: Archival
# Author: Erik Larsson
# License: GNU General Public License v3+ (https://github.com/unsound/hfsexplorer/blob/master/doc/gpl.txt)
# Version: 2021.10.9
# Notes: 

{% set version = '2021.10.9' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'f4f55575d3e91fcce05dd994ebc6babcec317a4b27ee986e8a9a37f936ea2d44' %}

hfs-explorer-download-only:
  file.managed:
    - name: '{{ downloads }}\hfs-exporer\hfs-explorer-{{ version }}-setup.exe'
    - source: https://github.com/unsound/hfsexplorer/releases/download/hfsexplorer-{{ version }}/hfsexplorer-{{ version }}-setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
