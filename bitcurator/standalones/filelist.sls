# Name: filelist
# Website: https://www.jam-software.com/filelist
# Description: Creates lists of files on your PC
# Category: Archival
# Author: Jam Software
# License: Freeware (https://www.jam-software.com/company/license_agreement.shtml#freeware-and-trial-versions-570287)
# Version: 4.3.2
# Notes: 

{% set version = '4.3.2' %}
{% set hash = '72d53318e03ba5aecdb3b5bdca617dee05498a650d1a82ba5a0cd0d5e03dc416' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}

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

filelist-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\filelist\'
    - require:
      - archive: filelist-extract
