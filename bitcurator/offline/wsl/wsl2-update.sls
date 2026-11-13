# Name: WSL 2 System Update
# Website: https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# Description: Update for Windows Subsystem for Linux to version 2
# Category: Requirements
# Author: Microsoft
# License: EULA
# Version: 5.10.16
# Notes: 

{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'wsl_update_x64.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\wsl\\' + pkg) %}

{% if exists %}

wsl2-update-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\wsl\{{ pkg }}" /qn /norestart'
    - shell: cmd
    - cwd: '{{ downloads }}\wsl\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
