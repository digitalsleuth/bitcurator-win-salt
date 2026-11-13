# Name: karens-directory-printer
# Website: https://www.karenware.com/powertools/karens-directory-printer
# Description: 
# Category: Archival
# Author: Karen Kenworth, Joe Winett
# License: Free for Personal and Educational Use (https://www.karenware.com/licenseme)
# Version: 5.4.4
# Notes: 

{% set version = '5.4.4' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'Karens-Directory-Printer-v' ~ version ~ '-Setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\karens-directory-printer\\' + pkg) %}

{% if exists %}

karens-directory-printer-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\karens-directory-printer\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\karens-directory-printer\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
