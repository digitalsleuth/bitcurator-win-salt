# Name: fido
# Website: https://github.com/openpreserve/fido
# Description: Format Identification for Digital Objects (FIDO) is a command-line tool to identify file formats
# Category: Archival
# Author: Open Preserve Foundation
# License: Apache License v2.0 (https://github.com/openpreserve/fido/blob/main/LICENSE.txt)
# Version: 1.6.1
# Notes: 

include:
  - bitcurator.packages.python3

fido-install:
  pip.installed:
    - name: opf-fido
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: bitcurator.packages.python3
