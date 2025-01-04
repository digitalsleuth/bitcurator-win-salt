# Name: DROID
# Website: https://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/
# Description: File Format Identification Tool
# Category: Archival
# Author: The National Archives
# License: BSD License (https://raw.github.com/digital-preservation/droid/master/license.md)
# Version: 6.8.0
# Notes: Command Line and GUI, this will utilize the GUI by default, updates signature database on install

{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set version = '6.8.0' %}
{% set hash = '68ec8572485ea2c4d571829bd3c4f4f207b215eec9c5bb9e88189a75336e19e7' %}

droid-download-only:
  file.managed:
    - name: '{{ downloads }}\droid\droid-binary-{{ version }}-bin-win64-with-jre.zip'
    - source: https://github.com/digital-preservation/droid/releases/download/droid-{{ version }}/droid-binary-{{ version }}-bin-win64-with-jre.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
