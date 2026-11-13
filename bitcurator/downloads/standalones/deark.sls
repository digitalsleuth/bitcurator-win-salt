# Name: deark
# Website: https://entropymine.com/deark/
# Description: Portable command-line utility to decode file types
# Category: Archival
# Author: Jason Summers
# License: MIT (https://github.com/jsummers/deark/blob/master/COPYING)
# Version: 1.6.8
# Notes:

{% set version = '1.6.8' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('deark') %}

deark-download-only:
  file.managed:
    - name: '{{ downloads }}\deark\deark-{{ version }}.tar.gz'
    - source: https://entropymine.com/deark/releases/deark-{{ version }}.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True
