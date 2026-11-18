# Name: Windows Winget
# Website: https://github.com/microsoft/winget-cli
# Description: Windows Package Manager
# Category: Utilities
# Author: Microsoft
# License: MIT License (https://github.com/microsoft/winget-cli/blob/master/LICENSE)
# Version: 1.29.380
# Notes: 

{% set version = '1.29.380' %}
{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% set LOCALAPPDATA = salt['environ.get']('LOCALAPPDATA') %}
{% set winget_version = salt['cmd.powershell']('$(try { winget -v } catch { "0" }).split("v")[1]') %}

{% if version > winget_version and winget_version != '0' %}

windows-winget-download:
  file.managed:
    - name: 'C:\salt\tempdownload\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
    - source: https://github.com/microsoft/winget-cli/releases/download/v{{ version }}/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    - skip_verify: True
    - makedirs: True

windows-winget-install:
  cmd.run:
    - name: "dism /Online /quiet /norestart /Add-ProvisionedAppxPackage /PackagePath:Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle /SkipLicense"
    - shell: cmd
    - success_retcodes: 3010
    - cwd: 'C:\salt\tempdownload\'
    - require:
      - file: windows-winget-download

{% else %}
Windows Winget is already installed and at a higher version - {{ winget_version }}:
  test.nop
{% endif %}
