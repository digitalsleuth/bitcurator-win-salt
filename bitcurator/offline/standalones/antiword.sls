# Name: antiword
# Website: https://github.com/grobian/antiword - https://cran.r-project.org/web/packages/antiword/index.html
# Description: 
# Category: Archival
# Author: Ardi van Os
# License: GNU General Public License
# Version: 1.3.5
# Notes: 

{% set version = '1.3.5' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'antiword_' ~ version ~ '.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\antiword\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

antiword-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - enforce_toplevel: True
    - source: '{{ downloads }}\antiword\{{ pkg }}'
    - overwrite: True

antiword-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\antiword\bin\antiword.exe -OutPath {{ inpath }}\shims\antiword.exe'
    - require:
      - archive: antiword-extract-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
