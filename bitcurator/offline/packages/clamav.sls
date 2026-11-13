# Name: clamav
# Website: https://www.clamav.net/
# Description: Open source anti-virus scanner
# Category: Archival
# Author: https://www.clamav.net/about
# License: GNU General Public License v2 (https://github.com/Cisco-Talos/clamav/blob/main/COPYING.txt)
# Version: 1.4.1
# Notes: 

{% set version = '1.4.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'clamav-' ~ version ~ '.win.x64.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\clamav\\' + pkg) %}
{% from 'bitcurator/_macros/is_installed.jinja' import check_installed %}
{% set installed = check_installed('ClamAV') | trim == 'true' %}

{% if not installed %}
{% if exists %}

clamav-install-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\clamav\{{ pkg }}" /qn /norestart'
    - shell: cmd
    - cwd: '{{ downloads }}\clamav\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}

{% else %}
ClamAV is already installed:
  test.nop
{% endif %}
