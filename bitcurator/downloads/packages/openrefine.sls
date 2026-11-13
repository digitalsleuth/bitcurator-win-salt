# Name: openrefine
# Website: https://openrefine.org/
# Description: Open source tool for working with messy data
# Category: Archival
# Author: OpenRefine
# License: BSD 3-Clause (https://github.com/OpenRefine/OpenRefine/blob/master/LICENSE.txt)
# Version: 3.8.7
# Notes: 

# renovate: datasource=github-releases depName=OpenRefine/OpenRefine
{% set version = '3.8.7' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('openrefine') %}

openrefine-download-only:
  file.managed:
    - name: '{{ downloads }}\openrefine\openrefine-win-with-java-installer-{{ version }}.exe'
    - source: https://github.com/OpenRefine/OpenRefine/releases/download/{{ version }}/openrefine-win-with-java-installer-{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
