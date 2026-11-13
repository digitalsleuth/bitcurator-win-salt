# Name: filelist
# Website: https://www.jam-software.com/filelist
# Description: Creates lists of files on your PC
# Category: Archival
# Author: Jam Software
# License: Freeware (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 5.0.0
# Notes: 

{% set version = '5.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'FileList-' ~ version ~ '.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\filelist\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

filelist-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\filelist\'
    - source: '{{ downloads }}\filelist\{{ pkg }}'
    - enforce_toplevel: False

filelist-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\filelist\FileList.exe -OutPath {{ inpath }}\shims\filelist.exe'
    - require:
      - archive: filelist-extract-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
