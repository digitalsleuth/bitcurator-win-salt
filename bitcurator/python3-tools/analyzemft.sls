# Name: analyzeMFT
# Website: https://github.com/rowingdude/analyzemft
# Description: Python tool to fully parse the MFT from an NTFS file system
# Category: Archival
# Author: Benjamin Cance (rowingdude)
# License: MIT License (https://github.com/rowingdude/analyzeMFT/blob/master/LICENSE.txt)
# Version: 3.0.6.6
# Notes:

{% set version = '3.0.6.6' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set commit = get_hash('analyzemft', 'commit') %}

include:
  - bitcurator.packages.python3

analyzemft-install:
  pip.installed:
    - name: git+https://github.com/rowingdude/analyzemft.git@{{ commit }}
    - bin_env: 'C:\Program Files\Python311\python.exe'
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3
