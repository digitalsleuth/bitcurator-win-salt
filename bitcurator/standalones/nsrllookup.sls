# Name: nsrllookup
# Website: https://rjhansen.github.io/nsrllookup/
# Description: Tool to look up the hash for a file in the NSRL
# Category: Archival
# Author: Robert J. Hansen
# License: ISC License (https://github.com/rjhansen/nsrllookup/blob/master/LICENSE)
# Version: 1.4.2
# Notes: 

{% set version = '1.4.2' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('nsrllookup') %}

include:
  - bitcurator.config.shims

nsrllookup-download:
  file.managed:
    - name: 'C:\salt\tempdownload\nsrllookup-{{ version }}-win64.zip'
    - source: https://github.com/rjhansen/nsrllookup/releases/download/{{ version }}/nsrllookup-{{ version }}-win64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

nsrllookup-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\nsrllookup-{{ version }}-win64.zip'
    - enforce_toplevel: True
    - overwrite: True
    - require:
      - file: nsrllookup-download

nsrllookup-rename:
  file.rename:
    - name: '{{ inpath }}\nsrllookup'
    - source: '{{ inpath }}\nsrllookup-{{ version }}-win64'
    - force: True
    - require:
      - archive: nsrllookup-extract

nsrllookup-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\nsrllookup\nsrllookup.exe -OutPath {{ inpath }}\shims\nsrllookup.exe'
    - require:
      - file: nsrllookup-rename
      - sls: bitcurator.config.shims
