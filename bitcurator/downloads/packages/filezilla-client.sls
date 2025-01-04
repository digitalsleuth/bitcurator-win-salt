# Name: filezilla
# Website: https://filezilla-project.org/
# Description: Free FTP Client
# Category: Archival
# Author: FileZilla Project
# License: GNU General Public License v2 (https://filezilla-project.org/license.php)
# Version: 3.68.1
# Notes: 

{% set version = '3.68.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '1feb6c12f584e98f9fddf95bf128f549310c738376fab82a5893eafed765ad83' %}

filezilla-client-download-only:
  file.managed:
    - name: '{{ downloads }}\filezilla-client\FileZilla_{{ version }}_win64-setup.exe'
    - source: https://github.com/digitalsleuth/salt-winrepo-ng/raw/refs/heads/main/files/FileZilla_{{ version }}_win64-setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
