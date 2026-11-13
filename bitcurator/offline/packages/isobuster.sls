# Name: isobuster
# Website: https://www.isobuster.com/download.php
# Description: File data recovery software
# Category: Archival
# Author: Smart Projects / Peter Van Hove
# License: Free (https://www.isobuster.com/license-models.php)
# Version: 5.8
# Notes: 

{% set version = '5.8' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'isobuster_install_64bit-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\isobuster\\' + pkg) %}

{% if exists %}

isobuster-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\isobuster\{{ pkg }}" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\isobuster\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
