# Name: libreoffice
# Website: https://www.libreoffice.org/download/download-libreoffice/
# Description: Open source Office-like document suite
# Category: Documents / Editors
# Author: The Document Foundation
# License: Free Software - Multiple (https://www.libreoffice.org/about-us/licenses)
# Version: 24.8.4.2
# Notes: 

{% set version = '24.8.4.2' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '76def06f2a8ecd5803dfbc63995e3963ae46b85e8c1c917541dedab81bd78169' %}

libreoffice-download-only:
  file.managed:
    - name: '{{ downloads }}\libreoffice\LibreOffice_{{ version }}_Win_x86-64.msi'
    - source: https://downloadarchive.documentfoundation.org/libreoffice/old/{{ version }}/win/x86_64/LibreOffice_{{ version }}_Win_x86-64.msi
    - source_hash: sha256={{ hash }}
    - makedirs: True
