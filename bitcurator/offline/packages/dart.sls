# Name: dart
# Website: https://aptrust.github.io/dart-docs/
# Description: Digital Archivist's Resource Tool
# Category: Archival
# Author: Academic Preservation Trust
# License: BSD 2-Clause License (https://github.com/APTrust/dart/blob/master/LICENSE)
# Version: 2.0.22
# Notes: 

{% set version = '2.0.22' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'DART+Setup+' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\dart\\' + pkg) %}

{% if exists %}

dart-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\dart\{{ pkg }}" /S /allusers --no-desktop-shortcut /D="%ProgramFiles%\\DART\\'
    - shell: cmd
    - cwd: '{{ downloads }}\dart\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
