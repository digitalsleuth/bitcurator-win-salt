# Name: Portals
# Website: https://portals-app.com
# Description: Desktop Organizer
# Category: Requirements
# Author: Ross Patterson
# License: Free To Use - Terms and Conditions (https://rosspat.dev/privacy/)
# Version: 3.2.1.0
# Notes:

{% set version = '3.2.1.0' %}
{% set dashes = version | replace(".","-") %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'portals_installer_v' ~ dashes ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\portals\\' + pkg) %}

{% if exists %}

portals-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\portals\{{ pkg }}" /ALLUSERS /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\portals\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
