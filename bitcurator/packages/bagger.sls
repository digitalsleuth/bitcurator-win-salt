# Name: bagger
# Website: https://github.com/LibraryOfCongress/bagger?tab=readme-ov-file
# Description: 
# Category: Archival
# Author: Library of Congress
# License: Multiple (https://github.com/LibraryOfCongress/bagger/blob/master/LICENSE.txt)
# Version: 2.8.1
# Notes: Requires Java - https://javadl.oracle.com/webapps/download/AutoDL?BundleId=251408_0d8f12bc927a4e2c9f8568ca567db4ee

{% set version = '2.8.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set hash = '8a1991e39764e007a336a5585e7c2c79a8edf406a63ef81d587b3c70b421af23' %}

include:
  - bitcurator.packages.jre8

bagger-download:
  file.managed:
    - name: 'C:\salt\tempdownload\bagger-{{ version }}.zip'
    - source: https://github.com/LibraryOfCongress/bagger/releases/download/v{{ version }}/bagger-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

bagger-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - enforce_toplevel: True
    - source: 'C:\salt\tempdownload\bagger-{{ version }}.zip'
    - overwrite: True
    - require:
      - file: bagger-download

bagger-folder-rename:
  file.rename:
    - name: '{{ inpath }}\bagger'
    - source: '{{ inpath }}\bagger-{{ version }}\'
    - force: True
    - makedirs: True
    - require:
      - archive: bagger-extract

bagger-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Bagger.lnk'
    - target: 'C:\Windows\System32\cmd.exe'
    - arguments: '/c {{ inpath }}\bagger\bin\bagger.bat'
    - force: True
    - working_dir: 'C:\Windows\System32'
    - makedirs: True
    - require:
      - file: bagger-download
      - archive: bagger-extract
      - file: bagger-folder-rename
      - sls: bitcurator.packages.jre8
