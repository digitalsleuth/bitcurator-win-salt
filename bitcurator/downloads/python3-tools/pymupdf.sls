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
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3

pymupdf-folder-download-only:
  file.directory:
    - name: '{{ downloads }}\pymupdf'
    - makedirs: True
    - force: True
    - win_inheritance: True

pymupdf-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages PyMuPDF'
    - cwd: '{{ downloads }}\pymupdf\'
    - require:
      - sls: bitcurator.standalones.portable-python3
      - file: pymupdf-folder-download-only
