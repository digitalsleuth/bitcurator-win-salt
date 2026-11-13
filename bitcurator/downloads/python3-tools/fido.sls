# Name: fido
# Website: https://github.com/openpreserve/fido
# Description: Format Identification for Digital Objects (FIDO) is a command-line tool to identify file formats
# Category: Archival
# Author: Open Preserve Foundation
# License: Apache License v2.0 (https://github.com/openpreserve/fido/blob/main/LICENSE.txt)
# Version: 1.6.1
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3

fido-folder-download-only:
  file.directory:
    - name: '{{ downloads }}\fido'
    - makedirs: True
    - force: True
    - win_inheritance: True

fido-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages opf-fido'
    - cwd: '{{ downloads }}\fido\'
    - require:
      - sls: bitcurator.standalones.portable-python3
      - file: fido-folder-download-only
