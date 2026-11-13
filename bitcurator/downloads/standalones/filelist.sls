# Name: filelist
# Website: https://www.jam-software.com/filelist
# Description: Creates lists of files on your PC
# Category: Archival
# Author: Jam Software
# License: Freeware (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 5.0.0
# Notes: 

{% set version = '5.0.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('filelist') %}

filelist-download-only:
  file.managed:
    - name: '{{ downloads }}\filelist\FileList-{{ version }}.zip'
    - source: https://downloads.jam-software.de/filelist/FileList.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
