# Name: DROID
# Website: https://www.nationalarchives.gov.uk/information-management/manage-information/preserving-digital-records/droid/
# Description: File Format Identification Tool
# Category: Archival
# Author: The National Archives
# License: BSD License (https://raw.github.com/digital-preservation/droid/master/license.md)
# Version: 6.9.14
# Notes: Command Line and GUI, this will utilize the GUI by default, updates signature database on install

{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set version = '6.9.14' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('droid') %}

droid-download-only:
  file.managed:
    - name: '{{ downloads }}\droid\droid-{{ version }}.zip'
    - source: https://github.com/digital-preservation/droid/releases/download/{{ version }}/droid-binary-{{ version }}-bin-win64-with-jre.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
