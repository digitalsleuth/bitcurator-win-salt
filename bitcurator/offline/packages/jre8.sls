# Name: Java Runtime Environment
# Website: https://www.java.com
# Description: Java Engine
# Category: Requirements
# Author: Oracle
# License: https://www.oracle.com/legal/terms.html
# Version: 8.0.4310.10
# Notes:

{% set version = '8.0.4310.10' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set file_ver = get_hash('jre8', 'file_ver') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'jre-' ~ file_ver ~ '-windows-x64.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\jre8\\' + pkg) %}

{% if exists %}

jre8-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\jre8\{{ pkg }}" /s REBOOT=Suppress SPONSORS=0 REMOVEOUTOFDATEJRES=1 AUTO_UPDATE=Disable'
    - shell: cmd
    - cwd: '{{ downloads }}\jre8\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
