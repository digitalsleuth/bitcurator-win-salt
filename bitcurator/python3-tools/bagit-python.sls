# Name: bagit-python
# Website: https://libraryofcongress.github.io/bagit-python/
# Description: Python library and command utility for working with BagIt style packages
# Category: Archival
# Author: Library of Congress
# License: 
# Version: 1.9.0
# Notes: 

# renovate: datasource=pypi depName=bagit
{% set version = '1.9.0' %}

include:
  - bitcurator.packages.python3

bagit-install:
  pip.installed:
    - name: bagit
    - bin_env: 'C:\Program Files\Python311\python.exe'
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3
