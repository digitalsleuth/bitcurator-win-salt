# Name: dfxml-python
# Website: https://github.com/dfxml-working-group/dfxml_python
# Description: DFXML file format designed to capture metadata and provenance info
# Category: Archival
# Author: DFXML Working Group
# License: Multiple (https://github.com/dfxml-working-group/dfxml_python/blob/main/LICENSE.md)
# Version: 0.0.0
# Notes: 

{% set version = '0.0.0' %}

include:
  - bitcurator.packages.python3

dfxml-python-install:
  pip.installed:
    - name: git+https://github.com/dfxml-working-group/dfxml_python
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: bitcurator.packages.python3
