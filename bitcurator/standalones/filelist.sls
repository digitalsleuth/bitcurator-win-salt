# Name: filelist
# Website: https://www.jam-software.com/filelist
# Description: Creates lists of files on your PC
# Category: Archival
# Author: Jam Software
# License: Freeware (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 5.0.0
# Notes: 

{% set version = '5.0.0' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('filelist') %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}

include:
  - bitcurator.config.shims

filelist-download:
  file.managed:
    - name: 'C:\salt\tempdownload\FileList-{{ version }}.zip'
    - source: https://downloads.jam-software.de/filelist/FileList.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

filelist-extract:
  archive.extracted:
    - name: '{{ inpath }}\filelist\'
    - source: 'C:\salt\tempdownload\FileList-{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: filelist-download

filelist-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\filelist\FileList.exe -OutPath {{ inpath }}\shims\filelist.exe'
    - require:
      - archive: filelist-extract
      - sls: bitcurator.config.shims
