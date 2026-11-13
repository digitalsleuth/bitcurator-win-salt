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
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3

bagit-python-folder-download-only:
  file.directory:
    - name: '{{ downloads }}\bagit-python'
    - makedirs: True
    - force: True
    - win_inheritance: True

bagit-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages bagit setuptools wheel'
    - cwd: '{{ downloads }}\bagit-python\'
    - require:
      - sls: bitcurator.standalones.portable-python3
      - file: bagit-python-folder-download-only
