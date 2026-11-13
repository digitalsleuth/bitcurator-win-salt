# Name: DROID
# Website: https://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/
# Description: File Format Identification Tool
# Category: Archival
# Author: The National Archives
# License: BSD License (https://raw.github.com/digital-preservation/droid/master/license.md)
# Version: 6.8.0
# Notes: Command Line and GUI, this will utilize the GUI by default, updates signature database on install

# renovate: datasource=github-releases depName=digital-preservation/droid
{% set version = '6.8.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'droid-binary-' ~ version ~ '-bin-win64-with-jre.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\droid\\' + pkg) %}

{% if exists %}

droid-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\droid\'
    - source: '{{ downloads }}\droid\{{ pkg }}'
    - overwrite: True
    - enforce_toplevel: False

droid-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\DROID.lnk'
    - target: {{ inpath }}\droid\droid.bat
    - force: True
    - working_dir: {{ inpath }}\droid\
    - makedirs: True
    - require:
      - archive: droid-extract-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
