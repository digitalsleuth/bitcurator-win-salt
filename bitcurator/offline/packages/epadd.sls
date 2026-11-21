# Name: epadd
# Website: https://www.epaddproject.org/
# Description:
# Category: Archival
# Author: Stanford University's Special Collections and University Archives
# License: Creative Commons Attribution 2.0 / Apache License v2.0 (https://github.com/ePADD/epadd/blob/main/README.md)
# Version: 11.1.4
# Notes: Will prompt for firewall access on first launch

# renovate: datasource=github-releases depName=ePADD/epadd
{% set version = '11.1.4' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set pkg = 'epadd-' ~ version ~ '.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\epadd\\' + pkg) %}

{% if exists %}

epadd-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\epadd\{{ pkg }}" ALLUSERS=1 /qn /norestart'
    - shell: cmd
    - cwd: '{{ downloads }}\epadd\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
