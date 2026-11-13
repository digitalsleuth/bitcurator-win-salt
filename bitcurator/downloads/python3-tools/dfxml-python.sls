# Name: dfxml-python
# Website: https://github.com/dfxml-working-group/dfxml_python
# Description: DFXML file format designed to capture metadata and provenance info
# Category: Archival
# Author: DFXML Working Group
# License: Multiple (https://github.com/dfxml-working-group/dfxml_python/blob/main/LICENSE.md)
# Version: 0.0.0
# Notes: 

{% set version = '0.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.packages.git
  - bitcurator.standalones.portable-python3

dfxml-python-clone-download-only:
  git.latest:
    - name: https://github.com/dfxml-working-group/dfxml_python.git
    - target: '{{ downloads }}\dfxml-python'
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git

dfxml-python-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages . setuptools wheel'
    - cwd: '{{ downloads }}\dfxml-python'
    - require:
      - git: dfxml-python-clone-download-only
      - sls: bitcurator.standalones.portable-python3
