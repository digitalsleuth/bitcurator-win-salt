# Name: pymupdf
# Website: https://github.com/pymupdf/PyMuPDF
# Description: Python library for data extraction and analysis of PDF
# Category: Archival
# Author: Jorj X. McKie and Artifex Software
# License: GNU Affero General Public License v3 (https://github.com/pymupdf/PyMuPDF/blob/main/COPYING)
# Version: 1.25.1
# Notes: 

# renovate: datasource=pypi depName=PyMuPDF
{% set version = '1.25.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exists = salt['file.directory_exists'](downloads + '\\pymupdf\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

pymupdf-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages PyMuPDF'
    - cwd: '{{ downloads }}\pymupdf\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ downloads }}\pymupdf\packages does not exist - not installing:
  test.nop
{% endif %}
