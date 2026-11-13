# Name: Bulk Extractor
# Website: https://digitalcorpora.org/downloads/bulk_extractor & https://github.com/simsong/bulk_extractor
# Description: Tool for extracting artifacts from random data
# Category: Archival
# Author: Simson L. Garfinkel
# License: MIT License (https://github.com/simsong/bulk_extractor/blob/main/LICENSE.md)
# Version: 1.5.5
# Notes:

{% set version = '1.5.5' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'bulk_extractor-' ~ version ~ '-windowsinstaller.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\bulk-extractor\\' + pkg) %}

{% if exists %}

bulk-extractor-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\bulk-extractor\{{ pkg }}"  /S'
    - shell: cmd
    - cwd: '{{ downloads }}\bulk-extractor\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
