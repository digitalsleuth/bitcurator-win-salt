# Name: nsrllookup
# Website: https://rjhansen.github.io/nsrllookup/
# Description: Tool to look up the hash for a file in the NSRL
# Category: Archival
# Author: Robert J. Hansen
# License: ISC License (https://github.com/rjhansen/nsrllookup/blob/master/LICENSE)
# Version: 1.4.2
# Notes: 

{% set version = '1.4.2' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('nsrllookup') %}

nsrllookup-download-only:
  file.managed:
    - name: '{{ downloads }}\nsrllookup\nsrllookup-{{ version }}-win64.zip'
    - source: https://github.com/rjhansen/nsrllookup/releases/download/{{ version }}/nsrllookup-{{ version }}-win64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
