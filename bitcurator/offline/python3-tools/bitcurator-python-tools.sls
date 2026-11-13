# Name: bitcurator-python-tools
# Website: https://github.com/bitcurator/bitcurator-python-tools
# Description: BitCurator Python 3 scripts as an installable pip package
# Category: Archival
# Author: Corey Forman (digitalsleuth), Kam Woods, Simson L. Garfinkel
# License: MIT License (https://github.com/BitCurator/bitcurator-python-tools/blob/main/licenses/LICENSE.MIT.md)
# Version: 1.0.0
# Notes:

{% set version = '1.0.0' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exists = salt['file.directory_exists'](downloads + '\\bitcurator-python-tools\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

bitcurator-python-tools-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages .'
    - cwd: '{{ downloads }}\bitcurator-python-tools\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ downloads }}\bitcurator-python-tools\packages does not exist - not installing:
  test.nop
{% endif %}
