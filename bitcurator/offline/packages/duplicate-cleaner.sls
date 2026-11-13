# Name: Duplicate Cleaner
# Website: https://www.duplicatecleaner.com/
# Description: Tool to identify and manage duplicate files in a file system
# Category: Archival
# Author: DigitalVolcano Software
# License: 7 Day Free Trial - License after trial
# Version: 5.28.0.0
# Notes: 

{% set version = '5.28.0.0' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'DuplicateCleaner-Setup-' ~ version.split(".")[0] ~ '.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\duplicate-cleaner\\' + pkg) %}

{% if exists %}

duplicate-cleaner-install-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\duplicate-cleaner\{{ pkg }}" /qn ALLUSERS=1 /norestart'
    - shell: cmd
    - cwd: '{{ downloads }}\duplicate-cleaner\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
