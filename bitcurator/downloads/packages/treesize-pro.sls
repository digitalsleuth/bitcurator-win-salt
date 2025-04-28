# Name: TreeSize Pro
# Website: https://www.jam-software.com/treesize
# Description: Graphical tool for managing storage spaces
# Category: Archival
# Author: Jam Software
# License: Trial Version of Pro (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 9.4.2
# Notes: 

{% set version = '9.4.2' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '10a281254f4c193e95d3ec539ec6724a6de6de488b2726f44d059d75ac0ee77c' %}

treesize-pro-download-only:
  file.managed:
    - name: '{{ downloads }}\treesize-pro\TreeSize-Setup-{{ version }}.exe'
    - source: https://downloads.jam-software.de/treesize/TreeSize-Setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
