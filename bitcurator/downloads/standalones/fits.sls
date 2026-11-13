# Name: fits
# Website: https://github.com/harvard-lts/fits
# Description: 
# Category: Archival
# Author: Harvard University
# License: GNU Lesser General Public License v2.1 (https://github.com/harvard-lts/fits/blob/main/LICENSE)
# Version: 1.6.0
# Notes: 

{% set version = '1.6.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('fits') %}

fits-download-only:
  file.managed:
    - name: '{{ downloads }}\fits\fits-{{ version }}.zip'
    - source: https://github.com/harvard-lts/fits/releases/download/{{ version }}/fits-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
