# Name: Windows Winget
# Website: https://github.com/microsoft/winget-cli
# Description: Windows Package Manager
# Category: Utilities
# Author: Microsoft
# License: MIT License (https://github.com/microsoft/winget-cli/blob/master/LICENSE)
# Version: 1.7.10861
# Notes: 

{% set version = '1.7.10861' %}
{% set LOCALAPPDATA = salt['environ.get']('LOCALAPPDATA') %}
{% if salt['file.file_exists'](LOCALAPPDATA + "\\Microsoft\\WindowsApps\\winget.exe") %}

winget-exists:
  test.nop

{% else %}

windows-winget-download:
  file.managed:
    - name: 'C:\salt\tempdownload\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
    - source: https://github.com/microsoft/winget-cli/releases/download/v{{ version }}/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    - skip_verify: True
    - makedirs: True

windows-winget-install:
  cmd.run:
    - name: "dism /Online /Add-ProvisionedAppxPackage /PackagePath:Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle /SkipLicense"
    - shell: cmd
    - cwd: 'C:\salt\tempdownload\'
    - require:
      - file: windows-winget-download

{% endif %}
