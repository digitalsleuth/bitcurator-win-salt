# Name: FTK Imager
# Website: https://www.exterro.com
# Description: Forensic Image Acquisition and Triage tool
# Category: Archival
# Author: Exterro Inc / AccessData
# License: EULA
# Version: 4.7.3.81
# Notes:

{% set version = '4.7.3.81' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'FTK-Imager-x64-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\ftk-imager\\' + pkg) %}

{% if exists %}

ftk-imager-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\ftk-imager\{{ pkg }}" /s /v/qn'
    - shell: cmd
    - cwd: '{{ downloads }}\ftk-imager\'

ftk-imager-del-shortcut-offline:
  file.absent:
    - name: 'C:\Users\Public\Desktop\Exterro FTK Imager.lnk'
    - require:
      - cmd: ftk-imager-install-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
