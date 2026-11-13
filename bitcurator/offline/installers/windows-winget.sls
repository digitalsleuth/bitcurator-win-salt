# Name: Windows Winget
# Website: https://github.com/microsoft/winget-cli
# Description: Windows Package Manager
# Category: Utilities
# Author: Microsoft
# License: MIT License (https://github.com/microsoft/winget-cli/blob/master/LICENSE)
# Version: 1.7.10861
# Notes:

# renovate: datasource=github-releases depName=microsoft/winget-cli
{% set version = '1.7.10861' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set LOCALAPPDATA = salt['environ.get']('LOCALAPPDATA') %}
{% set pkg = 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe-' ~ version ~ '.msixbundle' %}
{% set exists = salt['file.file_exists'](downloads + '\\windows-winget\\' + pkg) %}

{% if salt['file.file_exists'](LOCALAPPDATA + "\\Microsoft\\WindowsApps\\winget.exe") %}

winget-exists-offline:
  test.nop

{% elif exists %}

windows-winget-install-offline:
  cmd.run:
    - name: 'dism /Online /Add-ProvisionedAppxPackage /PackagePath:"{{ downloads }}\windows-winget\{{ pkg }}" /SkipLicense'
    - shell: cmd
    - cwd: '{{ downloads }}\windows-winget\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
