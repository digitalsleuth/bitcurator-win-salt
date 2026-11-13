# Name: analyzeMFT
# Website: https://github.com/rowingdude/analyzemft
# Description: Python tool to fully parse the MFT from an NTFS file system
# Category: Archival
# Author: Benjamin Cance (rowingdude)
# License: MIT License (https://github.com/rowingdude/analyzeMFT/blob/master/LICENSE.txt)
# Version: 3.0.6.6
# Notes:

{% set version = '3.0.6.6' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exists = salt['file.directory_exists'](downloads + '\\analyzemft\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

analyzemft-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages .'
    - cwd: '{{ downloads }}\analyzemft\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ downloads }}\analyzemft\packages does not exist - not installing:
  test.nop
{% endif %}
