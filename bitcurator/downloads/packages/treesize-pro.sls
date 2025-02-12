# Name: TreeSize Pro
# Website: https://www.jam-software.com/treesize
# Description: Graphical tool for managing storage spaces
# Category: Archival
# Author: Jam Software
# License: Trial Version of Pro (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 9.4
# Notes: 

{% set version = '9.4' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'fc07877837eec755379892e51e443fa7889d2a6579f22a72458a07da25f360d8' %}

treesize-pro-download-only:
  file.managed:
    - name: '{{ downloads }}\treesize-pro\TreeSize-Setup-{{ version }}.exe'
    - source: https://downloads.jam-software.de/treesize/TreeSize-Setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
