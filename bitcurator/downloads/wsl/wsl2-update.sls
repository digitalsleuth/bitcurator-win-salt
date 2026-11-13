# Name: WSL 2 System Update
# Website: https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# Description: Update for Windows Subsystem for Linux to version 2
# Category: Requirements
# Author: Microsoft
# License: EULA
# Version: 5.10.16
# Notes: 

{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

wsl2-update-download-only:
  file.managed:
    - name: '{{ downloads }}\wsl\wsl_update_x64.msi'
    - source: https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
    - skip_verify: True
    - makedirs: True
