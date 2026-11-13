# Name: fido
# Website: https://github.com/openpreserve/fido
# Description: Format Identification for Digital Objects (FIDO) is a command-line tool to identify file formats
# Category: Archival
# Author: Open Preserve Foundation
# License: Apache License v2.0 (https://github.com/openpreserve/fido/blob/main/LICENSE.txt)
# Version: 1.6.1
# Notes: 

{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exists = salt['file.directory_exists'](downloads + '\\fido\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

fido-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages opf-fido'
    - cwd: '{{ downloads }}\fido\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ downloads }}\fido\packages does not exist - not installing:
  test.nop
{% endif %}
