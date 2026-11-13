# Name: WinMerge
# Website: https://winmerge.org
# Description: File Differencing Tool
# Category: Archival
# Author: Dean P. Grimm (Thingamahoocie Software)
# License: GNU General Public License v2.0 (https://github.com/WinMerge/winmerge/blob/master/LICENSE.md)
# Version: 2.16.44
# Notes:

# renovate: datasource=github-releases depName=WinMerge/winmerge
{% set version = '2.16.44' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'WinMerge-' ~ version ~ '-x64-Setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\winmerge\\' + pkg) %}

{% if exists %}

winmerge-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\winmerge\{{ pkg }}" /SP- /VERYSILENT /NORESTART /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\winmerge\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
