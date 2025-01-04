# Name: isobuster
# Website: https://www.isobuster.com/download.php
# Description: File data recovery software
# Category: Archival
# Author: Smart Projects / Peter Van Hove
# License: Free (https://www.isobuster.com/license-models.php)
# Version: 5.5
# Notes: 

{% set version = '5.5' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '6017d9decd40c62e5e6b3ae64d25b1431589db57388bbae4f90243817a23917b' %}

isobuster-download-only:
  file.managed:
    - name: '{{ downloads }}\isobuster\isobuster_install_64bit-{{ version }}.exe'
    - source: https://www.isobuster.com/downloads/isobuster/isobuster_install_64bit.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
