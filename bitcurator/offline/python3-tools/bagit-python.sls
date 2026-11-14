# Name: bagit-python
# Website: https://libraryofcongress.github.io/bagit-python/
# Description: Python library and command utility for working with BagIt style packages
# Category: Archival
# Author: Library of Congress
# License: 
# Version: 1.8.1
# Notes: 

# renovate: datasource=pypi depName=bagit
{% set version = '1.8.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'bagit-'~ version ~'-py3-none-any.whl' %}
{% set exists = salt['file.file_exists'](downloads + '\\bagit-python\\packages\\' + pkg) %}

{% set exists = salt['file.directory_exists'](downloads + '\\bagit-python\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

bagit-python-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages bagit'
    - cwd: '{{ downloads }}\bagit-python\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ downloads }}\bagit-python\packages does not exist - not installing:
  test.nop
{% endif %}
