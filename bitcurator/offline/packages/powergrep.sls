# Name: powergrep
# Website: https://www.powergrep.com/
# Description: Graphical GREP tool for Windows
# Category: Archival
# Author: Jan Goyvaerts
# License: Free Trial
# Version: 5.4.2
# Notes: 

{% set version = '5.4.2' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'SetupPowerGREPDemo-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\powergrep\\' + pkg) %}

{% if exists %}

powergrep-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\powergrep\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\powergrep\'

powergrep-del-shortcut-offline:
  file.absent:
    - name: 'C:\Users\Public\Desktop\PowerGREP 5.lnk'
    - require:
      - cmd: powergrep-install-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
