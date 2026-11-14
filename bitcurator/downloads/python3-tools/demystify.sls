# Name: demystify
# Website: https://github.com/exponential-decay/demystify
# Description: Analysis engine for siegfried and DROID reports
# Category: Archival
# Author: Ross Spencer
# License: Copyright - As Is (https://github.com/exponential-decay/demystify/blob/main/LICENSE.txt)
# Version: 2.0.0
# Notes: demystify, sqlitefid, pathlesstaken

{% set version = '2.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3
  - bitcurator.downloads.packages.python3

demystify-download-only:
  file.managed:
    - name: '{{ downloads }}\demystify-{{ version }}.zip'
    - source: https://github.com/exponential-decay/demystify/archive/refs/tags/v{{ version }}.zip
    - skip_verify: True
    - makedirs: True

demystify-extract-download-only:
  archive.extracted:
    - name: '{{ downloads }}\'
    - source: '{{ downloads }}\demystify-{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: demystify-download-only

demystify-folder-rename-download-only:
  file.rename:
    - name: '{{ downloads }}\demystify'
    - source: '{{ downloads }}\demystify-{{ version }}'
    - force: True
    - makedirs: True
    - require:
      - archive: demystify-extract-download-only

demystify-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages . setuptools wheel'
    - cwd: '{{ downloads }}\demystify'
    - require:
      - file: demystify-download-only
      - archive: demystify-extract-download-only
      - file: demystify-folder-rename-download-only
      - sls: bitcurator.standalones.portable-python3
      - sls: bitcurator.downloads.packages.python3
