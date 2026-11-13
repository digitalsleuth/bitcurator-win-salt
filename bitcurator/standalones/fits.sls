# Name: fits
# Website: https://github.com/harvard-lts/fits
# Description: 
# Category: Archival
# Author: Harvard University
# License: GNU Lesser General Public License v2.1 (https://github.com/harvard-lts/fits/blob/main/LICENSE)
# Version: 1.6.0
# Notes: 

{% set version = '1.6.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('fits') %}

include:
  - bitcurator.packages.openjdk-adoptium
  - bitcurator.config.shims

fits-download:
  file.managed:
    - name: 'C:\salt\tempdownload\fits-{{ version }}.zip'
    - source: https://github.com/harvard-lts/fits/releases/download/{{ version }}/fits-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

fits-extract:
  archive.extracted:
    - name: '{{ inpath }}\fits\'
    - source: 'C:\salt\tempdownload\fits-{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: fits-download
      - sls: bitcurator.packages.openjdk-adoptium

fits-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\fits\fits.bat -OutPath {{ inpath }}\shims\fits.exe'
    - require:
      - archive: fits-extract
      - sls: bitcurator.config.shims
