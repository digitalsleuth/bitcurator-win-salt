# Name: FilelistCreator
# Website: https://www.sttmedia.com/filelistcreator
# Description: 
# Category: Archival
# Author: Stefan Trost
# License: Custom - https://www.sttmedia.com/licence
# Version: 24.8.29
# Notes:

{% set version = '24.8.29' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('filelistcreator') %}

filelistcreator-download-only:
  file.managed:
    - name: '{{ downloads }}\filelistcreator\FilelistCreatorWin64-{{ version }}.zip'
    - source: https://www.sttmedia.com/downloads/FilelistCreatorWin64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
