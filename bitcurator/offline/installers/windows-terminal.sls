# Name: Windows Terminal
# Website: https://github.com/microsoft/terminal
# Description: Terminal Emulator
# Category: Terminals
# Author: Microsoft
# License: MIT License (https://github.com/microsoft/terminal/blob/main/LICENSE)
# Version: 1.20.11781.0
# Notes:

# renovate: datasource=github-releases depName=microsoft/terminal
{% set version = '1.20.11781.0' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set TERMINAL_VERSION = salt['cmd.run']('powershell -c "(Get-AppxPackage -Name Microsoft.WindowsTerminal).Version"') %}
{% set TERMINAL_PKG = salt['cmd.run']('powershell -c "(Get-AppxPackage -Name Microsoft.WindowsTerminal).PackageFullName"') %}
{% set pkg = 'Microsoft.WindowsTerminal_' ~ version ~ '_8wekyb3d8bbwe.msixbundle' %}
{% set exists = salt['file.file_exists'](downloads + '\\windows-terminal\\' + pkg) %}

{% if exists %}

{% if TERMINAL_PKG != '' and TERMINAL_VERSION.split('.') | map('int') | list >= version.split('.') | map('int') | list %}
Selected version is not higher than the installed version - not replacing existing Microsoft Terminal:
  test.nop

{% else %}

{% if TERMINAL_PKG != '' %}
windows-terminal-remove-existing-offline:
  cmd.run:
    - name: "Remove-AppxPackage -Package {{ TERMINAL_PKG }} -AllUsers"
    - shell: powershell

{% endif %}
windows-terminal-install-offline:
  cmd.run:
    - name: 'dism /Online /Add-ProvisionedAppxPackage /PackagePath:"{{ downloads }}\windows-terminal\{{ pkg }}" /SkipLicense'
    - shell: cmd
    - cwd: '{{ downloads }}\windows-terminal\'
{% if TERMINAL_PKG != '' %}
    - require:
      - cmd: windows-terminal-remove-existing-offline
{% endif %}

windows-terminal-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Terminal.lnk'
    - target: 'C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_{{ version }}_x64__8wekyb3d8bbwe\wt.exe'
    - force: True
    - working_dir: 'C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_{{ version }}_x64__8wekyb3d8bbwe\'
    - makedirs: True
    - require:
      - cmd: windows-terminal-install-offline

{% endif %}

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
