# Name: analyzeMFT
# Website: https://github.com/rowingdude/analyzemft
# Description: Python tool to fully parse the MFT from an NTFS file system
# Category: Archival
# Author: Benjamin Cance (rowingdude)
# License: MIT License (https://github.com/rowingdude/analyzeMFT/blob/master/LICENSE.txt)
# Version: 3.0.6.6
# Notes:

{% set version = '3.0.6.6' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set commit = get_hash('analyzemft', 'commit') %}

include:
  - bitcurator.packages.git
  - bitcurator.standalones.portable-python3

analyzemft-clone-download-only:
  git.latest:
    - name: https://github.com/rowingdude/analyzemft.git
    - target: '{{ downloads }}\analyzemft'
    - rev: '{{ commit }}'
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git

analyzemft-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages . setuptools wheel'
    - cwd: '{{ downloads }}\analyzemft'
    - require:
      - git: analyzemft-clone-download-only
      - sls: bitcurator.standalones.portable-python3
