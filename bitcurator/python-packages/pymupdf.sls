# Name: pymupdf
# Website: https://github.com/pymupdf/PyMuPDF
# Description: Python library for data extraction and analysis of PDF
# Category: Archival
# Author: Jorj X. McKie and Artifex Software
# License: GNU Affero General Public License v3 (https://github.com/pymupdf/PyMuPDF/blob/main/COPYING)
# Version: 1.25.1
# Notes: 

{% set version = '1.25.1' %}

include:
  - bitcurator.packages.python3

pymupdf-install:
  pip.installed:
    - name: PyMuPDF
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: bitcurator.packages.python3
