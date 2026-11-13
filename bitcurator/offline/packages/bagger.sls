# Name: bagger
# Website: https://github.com/LibraryOfCongress/bagger?tab=readme-ov-file
# Description:
# Category: Archival
# Author: Library of Congress
# License: Multiple (https://github.com/LibraryOfCongress/bagger/blob/master/LICENSE.txt)
# Version: 2.8.1
# Notes: Requires Java - https://javadl.oracle.com/webapps/download/AutoDL?BundleId=251408_0d8f12bc927a4e2c9f8568ca567db4ee

# renovate: datasource=github-releases depName=LibraryOfCongress/bagger
{% set version = '2.8.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set pkg = 'bagger-' ~ version ~ '.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\bagger\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.jre8

bagger-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - enforce_toplevel: True
    - source: '{{ downloads }}\bagger\{{ pkg }}'
    - overwrite: True

bagger-folder-rename-offline:
  file.rename:
    - name: '{{ inpath }}\bagger'
    - source: '{{ inpath }}\bagger-{{ version }}\'
    - force: True
    - makedirs: True
    - require:
      - archive: bagger-extract-offline

bagger-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Bagger.lnk'
    - target: 'C:\Windows\System32\cmd.exe'
    - arguments: '/c {{ inpath }}\bagger\bin\bagger.bat'
    - force: True
    - working_dir: 'C:\Windows\System32'
    - makedirs: True
    - require:
      - archive: bagger-extract-offline
      - file: bagger-folder-rename-offline
      - sls: bitcurator.offline.packages.jre8

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
