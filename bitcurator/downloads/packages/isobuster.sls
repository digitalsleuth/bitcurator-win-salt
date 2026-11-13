# Name: isobuster
# Website: https://www.isobuster.com/download.php
# Description: File data recovery software
# Category: Archival
# Author: Smart Projects / Peter Van Hove
# License: Free (https://www.isobuster.com/license-models.php)
# Version: 5.8
# Notes: 

{% set version = '5.8' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('isobuster') %}

isobuster-download-only:
  file.managed:
    - name: '{{ downloads }}\isobuster\isobuster_install_64bit-{{ version }}.exe'
    - source: https://www.isobuster.com/downloads/isobuster/isobuster_install_64bit.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
