# Name: mailbagit
# Website: https://github.com/UAlbanyArchives/mailbagit
# Description: Tool to preserve emails using multiple preservation formats
# Category: Archival
# Author: University of Albany
# License: MIT License (https://github.com/UAlbanyArchives/mailbagit/blob/main/LICENSE)
# Version: 0.7.3
# Notes: 

{% set version = '0.7.3' %}

include:
  - bitcurator.packages.python3

mailbagit-install:
  pip.installed:
    - names:
      - mailbagit
      - mailbagit[gui]
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3

