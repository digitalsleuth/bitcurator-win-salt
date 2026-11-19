# Name: mailbagit
# Website: https://github.com/UAlbanyArchives/mailbagit
# Description: Tool to preserve emails using multiple preservation formats
# Category: Archival
# Author: University of Albany
# License: MIT License (https://github.com/UAlbanyArchives/mailbagit/blob/main/LICENSE)
# Version: 0.7.5
# Notes: 

# renovate: datasource=pypi depName=mailbagit
{% set version = '0.7.5' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3
  - bitcurator.downloads.packages.python3

mailbagit-folder-download-only:
  file.directory:
    - name: '{{ downloads }}\mailbagit'
    - makedirs: True
    - force: True
    - win_inheritance: True

mailbagit-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages mailbagit mailbagit[gui] setuptools wheel'
    - cwd: '{{ downloads }}\mailbagit\'
    - require:
      - sls: bitcurator.standalones.portable-python3
      - file: mailbagit-folder-download-only
      - sls: bitcurator.downloads.packages.python3
