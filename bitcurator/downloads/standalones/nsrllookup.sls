# Name: nsrllookup
# Website: https://rjhansen.github.io/nsrllookup/
# Description: Tool to look up the hash for a file in the NSRL
# Category: Archival
# Author: Robert J. Hansen
# License: ISC License (https://github.com/rjhansen/nsrllookup/blob/master/LICENSE)
# Version: 1.4.2
# Notes: 

{% set version = '1.4.2' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '042023f7b19c6e08045f4ccee4c32283e46853474f0d9e2815f6232dc4b51b66' %}

nsrllookup-download-only:
  file.managed:
    - name: '{{ downloads }}\nsrllookup\nsrllookup-{{ version }}-win64.zip'
    - source: https://github.com/rjhansen/nsrllookup/releases/download/{{ version }}/nsrllookup-{{ version }}-win64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
