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
  - bitcurator.standalones.portable-python3
  - bitcurator.downloads.packages.python3

dfxml-python-download-only:
  file.managed:
    - name: '{{ downloads }}\dfxml-python-main.zip'
    - source: https://github.com/dfxml-working-group/dfxml_python/archive/refs/heads/main.zip
    - skip_verify: True
    - makedirs: True

dfxml-python-extract-download-only:
  archive.extracted:
    - name: '{{ downloads }}\'
    - source: '{{ downloads }}\dfxml-python-main.zip'
    - enforce_toplevel: False
    - require:
      - file: dfxml-python-download-only

dfxml-python-folder-rename-download-only:
  file.rename:
    - name: '{{ downloads }}\dfxml-python'
    - source: '{{ downloads }}\dfxml_python-main'
    - force: True
    - makedirs: True
    - require:
      - archive: dfxml-python-extract-download-only

dfxml-python-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages . setuptools wheel'
    - cwd: '{{ downloads }}\dfxml-python'
    - require:
      - file: dfxml-python-download-only
      - archive: dfxml-python-extract-download-only
      - file: dfxml-python-folder-rename-download-only
      - sls: bitcurator.standalones.portable-python3
      - sls: bitcurator.downloads.packages.python3

dfxml-python-delete-archive:
  file.absent:
    - name: '{{ downloads }}\dfxml-python-main.zip'
    - require:
      - archive: dfxml-python-extract-download-only

