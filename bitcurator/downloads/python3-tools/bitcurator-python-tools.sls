# Name: bitcurator-python-tools
# Website: https://github.com/bitcurator/bitcurator-python-tools
# Description: BitCurator Python 3 scripts as an installable pip package
# Category: Archival
# Author: Corey Forman (digitalsleuth), Kam Woods, Simson L. Garfinkel
# License: MIT License (https://github.com/BitCurator/bitcurator-python-tools/blob/main/licenses/LICENSE.MIT.md)
# Version: 1.0.0
# Notes:

{% set version = '1.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3
  - bitcurator.downloads.packages.python3

bitcurator-python-tools-download-only:
  file.managed:
    - name: '{{ downloads }}\bitcurator-python-tools-{{ version }}.zip'
    - source: https://github.com/BitCurator/bitcurator-python-tools/archive/refs/heads/main.zip
    - skip_verify: True
    - makedirs: True

bitcurator-python-tools-extract-download-only:
  archive.extracted:
    - name: '{{ downloads }}\'
    - source: '{{ downloads }}\bitcurator-python-tools-{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: bitcurator-python-tools-download-only

bitcurator-python-tools-folder-rename-download-only:
  file.rename:
    - name: '{{ downloads }}\bitcurator-python-tools'
    - source: '{{ downloads }}\bitcurator-python-tools-main'
    - force: True
    - makedirs: True
    - require:
      - archive: bitcurator-python-tools-extract-download-only

bitcurator-python-tools-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages . setuptools wheel'
    - cwd: '{{ downloads }}\bitcurator-python-tools'
    - require:
      - file: bitcurator-python-tools-download-only
      - archive: bitcurator-python-tools-extract-download-only
      - file: bitcurator-python-tools-folder-rename-download-only
      - sls: bitcurator.standalones.portable-python3
      - sls: bitcurator.downloads.packages.python3
