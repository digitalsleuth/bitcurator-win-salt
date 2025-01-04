# Name: FilelistCreator
# Website: https://www.sttmedia.com/filelistcreator
# Description: 
# Category: Archival
# Author: Stefan Trost
# License: Custom - https://www.sttmedia.com/licence
# Version: 24.8.29
# Notes:

{% set version = '24.8.29' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'cfe34a5345c49f1680775f4c585536e804b9a1991a3f5d983ac8f902d3682b17' %}

filelistcreator-download-only:
  file.managed:
    - name: '{{ downloads }}\filelistcreator\FilelistCreatorWin64-{{ version }}.zip'
    - source: https://www.sttmedia.com/downloads/FilelistCreatorWin64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
