# Name: libreoffice
# Website: https://www.libreoffice.org/download/download-libreoffice/
# Description: Open source Office-like document suite
# Category: Documents / Editors
# Author: The Document Foundation
# License: Free Software - Multiple (https://www.libreoffice.org/about-us/licenses)
# Version: 24.8.4.2
# Notes: 

{% set version = '24.8.4.2' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'LibreOffice_' ~ version ~ '_Win_x86-64.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\libreoffice\\' + pkg) %}
{% from 'bitcurator/_macros/is_installed.jinja' import check_installed %}
{% set installed = check_installed('LibreOffice*') | trim == 'true' %}

{% if not installed %}
{% if exists %}

libreoffice-install-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\libreoffice\{{ pkg }}" /qn /norestart CREATEDESKTOPLINK=0'
    - shell: cmd
    - cwd: '{{ downloads }}\libreoffice\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}

{% else %}
LibreOffice is already installed:
  test.nop
{% endif %}
