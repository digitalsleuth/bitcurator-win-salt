# Name: dfxml-python
# Website: https://github.com/dfxml-working-group/dfxml_python
# Description: DFXML file format designed to capture metadata and provenance info
# Category: Archival
# Author: DFXML Working Group
# License: Multiple (https://github.com/dfxml-working-group/dfxml_python/blob/main/LICENSE.md)
# Version: 0.0.0
# Notes: 

{% set version = '0.0.0' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exists = salt['file.directory_exists'](downloads + '\\dfxml-python\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

dfxml-python-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages .'
    - cwd: '{{ downloads }}\dfxml-python\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ downloads }}\dfxml-python\packages does not exist - not installing:
  test.nop
{% endif %}
