# Name: Notepad++
# Website: https://notepad-plus-plus.org
# Description: Free source code / text editor
# Category: Documents / Editors
# Author: Don Ho
# License: GNU General Public License 2.0 (https://notepad-plus-plus.org/)
# Version: 8.9.9.1
# Notes: 

# renovate: datasource=github-releases depName=notepad-plus-plus/notepad-plus-plus
{% set version = '8.9.9.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'npp.' ~ version ~ '.Installer.x64.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\notepad-plus-plus\\' + pkg) %}

{% if exists %}

notepad-plus-plus-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\notepad-plus-plus\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\notepad-plus-plus\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
