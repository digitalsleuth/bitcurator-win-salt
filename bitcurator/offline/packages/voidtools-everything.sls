# Name: Voidtools Everything
# Website: https://www.voidtools.com
# Description: File Search Utility
# Category: Utilities
# Author: David Carpenter
# License: https://www.voidtools.com/License.txt
# Version: 1.4.1.1026
# Notes: 

{% set version = '1.4.1.1026' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'Everything-' ~ version ~ '.x64-Setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\voidtools-everything\\' + pkg) %}

{% if exists %}

voidtools-everything-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\voidtools-everything\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\voidtools-everything\'

voidtools-everything-remove-shortcut-offline:
  file.absent:
    - name: 'C:\Users\Public\Desktop\Everything.lnk'
    - require:
      - cmd: voidtools-everything-install-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
