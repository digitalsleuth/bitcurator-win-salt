# Name: DROID
# Website: https://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/
# Description: File Format Identification Tool
# Category: Archival
# Author: The National Archives
# License: BSD License (https://raw.github.com/digital-preservation/droid/master/license.md)
# Version: 6.8.0
# Notes: Command Line and GUI, this will utilize the GUI by default, updates signature database on install

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '6.8.0' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set hash = '68ec8572485ea2c4d571829bd3c4f4f207b215eec9c5bb9e88189a75336e19e7' %}

droid-download:
  file.managed:
    - name: 'C:\salt\tempdownload\droid-binary-{{ version }}-bin-win64-with-jre.zip'
    - source: https://github.com/digital-preservation/droid/releases/download/droid-{{ version }}/droid-binary-{{ version }}-bin-win64-with-jre.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

droid-extract:
  archive.extracted:
    - name: '{{ inpath }}\droid\'
    - source: 'C:\salt\tempdownload\droid-binary-{{ version }}-bin-win64-with-jre.zip'
    - overwrite: True
    - enforce_toplevel: False
    - require:
      - file: droid-download

droid-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\DROID.lnk'
    - target: {{ inpath }}\droid\droid.bat
    - force: True
    - working_dir: {{ inpath }}\droid\
    - makedirs: True
    - require:
      - archive: droid-extract

droid-signature-update:
  cmd.run:
    - name: '{{ inpath }}\droid\jre\bin\java.exe -jar {{ inpath }}\droid\droid-command-line-{{ version }}.jar -d'
    - shell: cmd
    - require:
      - archive: droid-extract

