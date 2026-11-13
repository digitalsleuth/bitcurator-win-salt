# Name: TeraCopy
# Website: https://www.codesector.com/teracopy
# Description: File transfer utility for consistent and uninterrupted transfers
# Category: Utilities
# Author: Code Sector
# License: FREEWARE (private / non-commerical)
# Version: 3.17
# Notes:

{% set version = '317' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'teracopy' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\teracopy\\' + pkg) %}

{% if exists %}

teracopy-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\teracopy\{{ pkg }}" /exenoupdates /quiet'
    - shell: cmd
    - cwd: '{{ downloads }}\teracopy\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
