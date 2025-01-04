# Name: mupdf
# Website: https://www.mupdf.com
# Description: Open source framework for viewing and converting PDF, XPS, and E-Book documents.
# Category: Archival
# Author: Multiple (https://github.com/ArtifexSoftware/mupdf/blob/master/CONTRIBUTORS)
# License: GNU Affero General Public License v3 (https://github.com/ArtifexSoftware/mupdf/blob/master/COPYING)
# Version: 1.25.2
# Notes: 

{% set version = '1.25.2' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '8cdd89ab8e638e7fd9e2ae3e75dd980aafe507bea63ad7a2eeaff1be403fff8c' %}

mupdf-download-only:
  file.managed:
    - name: '{{ downloads }}\mupdf\mupdf-{{ version }}-windows.zip'
    - source: https://mupdf.com/downloads/archive/mupdf-{{ version }}-windows.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
