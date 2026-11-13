# Name: mailbagit
# Website: https://github.com/UAlbanyArchives/mailbagit
# Description: Tool to preserve emails using multiple preservation formats
# Category: Archival
# Author: University of Albany
# License: MIT License (https://github.com/UAlbanyArchives/mailbagit/blob/main/LICENSE)
# Version: 0.7.3
# Notes: 

# renovate: datasource=pypi depName=mailbagit
{% set version = '0.7.3' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'mailbagit-' ~ version ~ '-py3-none-any.whl' %}
{% set exists = salt['file.file_exists'](downloads + '\\mailbagit\\packages\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

mailbagit-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages mailbagit "mailbagit[gui]"'
    - cwd: '{{ downloads }}\mailbagit\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
