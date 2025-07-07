# Name: TreeSize Pro
# Website: https://www.jam-software.com/treesize
# Description: Graphical tool for managing storage spaces
# Category: Archival
# Author: Jam Software
# License: Trial Version of Pro (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 9.5.1
# Notes: 

{% set version = '9.5.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '87a4b3181bee040095ff1f22bef00de8c5c9c729c820345a439b063eb92d2816' %}

treesize-pro-download-only:
  file.managed:
    - name: '{{ downloads }}\treesize-pro\TreeSize-Setup-{{ version }}.exe'
    - source: https://downloads.jam-software.de/treesize/TreeSize-Setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
