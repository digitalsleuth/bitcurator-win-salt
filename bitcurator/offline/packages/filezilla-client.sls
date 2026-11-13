# Name: filezilla
# Website: https://filezilla-project.org/
# Description: Free FTP Client
# Category: Archival
# Author: FileZilla Project
# License: GNU General Public License v2 (https://filezilla-project.org/license.php)
# Version: 3.68.1
# Notes: 

{% set version = '3.68.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'FileZilla_' ~ version ~ '_win64-setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\filezilla-client\\' + pkg) %}

{% if exists %}

filezilla-client-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\filezilla-client\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\filezilla-client\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
