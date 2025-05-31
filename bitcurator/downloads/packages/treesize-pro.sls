# Name: TreeSize Pro
# Website: https://www.jam-software.com/treesize
# Description: Graphical tool for managing storage spaces
# Category: Archival
# Author: Jam Software
# License: Trial Version of Pro (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 9.5
# Notes: 

{% set version = '9.5' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '8857c6a6dffe66ac6990f637a827f449bbf307ef795de2853fe19d3786c512b0' %}

treesize-pro-download-only:
  file.managed:
    - name: '{{ downloads }}\treesize-pro\TreeSize-Setup-{{ version }}.exe'
    - source: https://downloads.jam-software.de/treesize/TreeSize-Setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
