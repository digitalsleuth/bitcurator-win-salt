# Name: bitcurator-python-tools
# Website: https://github.com/bitcurator/bitcurator-python-tools
# Description: BitCurator Python 3 scripts as an installable pip package
# Category: Archival
# Author: Corey Forman (digitalsleuth), Kam Woods, Simson L. Garfinkel
# License: MIT License (https://github.com/BitCurator/bitcurator-python-tools/blob/main/licenses/LICENSE.MIT.md)
# Version: 1.0.0
# Notes:

{% set version = '1.0.0' %}

include:
  - bitcurator.packages.python3

bitcurator-python-tools-install:
  pip.installed:
    - name: git+https://github.com/bitcurator/bitcurator-python-tools.git
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3
