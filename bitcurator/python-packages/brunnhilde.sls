# Name: brunnhilde
# Website: https://github.com/tw4l/brunnhilde
# Description: 
# Category: Archival
# Author: Tessa Walsh
# License: MIT License (https://github.com/tw4l/brunnhilde/blob/main/LICENSE)
# Version: 1.9.6
# Notes: GUI not yet ready for Windows - https://github.com/tw4l/brunnhilde-gui

{% set version = '1.9.6' %}
include:
  - bitcurator.packages.python3

brunnhilde-install:
  pip.installed:
    - name: brunnhilde
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3
