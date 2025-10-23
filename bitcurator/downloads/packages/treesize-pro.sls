# Name: TreeSize Pro
# Website: https://www.jam-software.com/treesize
# Description: Graphical tool for managing storage spaces
# Category: Archival
# Author: Jam Software
# License: Trial Version of Pro (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 9.6.1
# Notes: 

{% set version = '9.6.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '0b43ae545e5634914357bbd4a0ae55ca0fbd026ec0e0d0b788eecaff31397842' %}

treesize-pro-download-only:
  file.managed:
    - name: '{{ downloads }}\treesize-pro\TreeSize-Setup-{{ version }}.exe'
    - source: https://downloads.jam-software.de/treesize/TreeSize-Setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
