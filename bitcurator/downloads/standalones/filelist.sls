# Name: filelist
# Website: https://www.jam-software.com/filelist
# Description: Creates lists of files on your PC
# Category: Archival
# Author: Jam Software
# License: Freeware (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 4.4.1
# Notes: 

{% set version = '4.4.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '8086cdbb3e8ff5dde07a74a1c0df504feb46e3ad1afb562e31151e9d3ea8a6aa' %}

filelist-download-only:
  file.managed:
    - name: '{{ downloads }}\filelist\FileList-{{ version }}.zip'
    - source: https://downloads.jam-software.de/filelist/FileList.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
