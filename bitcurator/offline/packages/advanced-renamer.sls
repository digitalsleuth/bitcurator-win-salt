# Name: advanced-renamer
# Website: https://www.advancedrenamer.com/
# Description: 
# Category: Archival
# Author: Kim Jensen (https://www.advancedrenamer.com/about)
# License: https://advancedrenamer.com/license
# Version: 4.28
# Notes: 

{% set version = '4.28' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'advanced_renamer_setup_' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\advanced-renamer\\' + pkg) %}

{% if exists %}

advanced-renamer-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\advanced-renamer\{{ pkg }}" /SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\advanced-renamer\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
