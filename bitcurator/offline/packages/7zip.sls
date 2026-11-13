# Name: 7-Zip
# Website: https://7-zip.org
# Description: Zip Compiler and Extractor
# Category: Utilities
# Author: Igor Pavlov
# License: GNU LGPL (https://www.7-zip.org/faq.html)
# Version: 24.06
# Notes:

{% set version = '2406' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = '7z' ~ version ~ '-x64.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\7zip\\' + pkg) %}
{% from 'bitcurator/_macros/is_installed.jinja' import check_installed %}
{% set installed = check_installed('7-Zip') | trim == 'true' %}

{% if not installed %}
{% if exists %}

7zip-install-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\7zip\{{ pkg }}" /qn /norestart'
    - shell: cmd
    - cwd: '{{ downloads }}\7zip\'

7zip-env-vars-offline:
  win_path.exists:
    - name: 'C:\Program Files\7-Zip'
    - require:
      - cmd: 7zip-install-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}

{% else %}
7-Zip is already installed:
  test.nop
{% endif %}
