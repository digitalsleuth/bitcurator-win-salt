# Name: TreeSize Pro
# Website: https://www.jam-software.com/treesize
# Description: Graphical tool for managing storage spaces
# Category: Archival
# Author: Jam Software
# License: Trial Version of Pro (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 9.9.1
# Notes: 

{% set version = '9.9.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'TreeSize-Setup-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\treesize-pro\\' + pkg) %}

{% if exists %}

treesize-pro-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\treesize-pro\{{ pkg }}" /SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\treesize-pro\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
