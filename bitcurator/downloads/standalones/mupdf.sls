# Name: mupdf
# Website: https://www.mupdf.com
# Description: Open source framework for viewing and converting PDF, XPS, and E-Book documents.
# Category: Archival
# Author: Multiple (https://github.com/ArtifexSoftware/mupdf/blob/master/CONTRIBUTORS)
# License: GNU Affero General Public License v3 (https://github.com/ArtifexSoftware/mupdf/blob/master/COPYING)
# Version: 1.25.2
# Notes: 

{% set version = '1.25.2' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('mupdf') %}

mupdf-download-only:
  file.managed:
    - name: '{{ downloads }}\mupdf\mupdf-{{ version }}-windows.zip'
    - source: https://mupdf.com/downloads/archive/mupdf-{{ version }}-windows.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
