# Name: dupeguru
# Website: https://dupeguru.voltaicideas.net/
# Description: Cross-platform tool to find duplicate files in a system
# Category: Archival
# Author: Andrew Senetar
# License: GNU General Public License v3 (https://github.com/arsenetar/dupeguru/blob/master/LICENSE)
# Version: 4.3.1
# Notes: 

# renovate: datasource=github-releases depName=arsenetar/dupeguru
{% set version = '4.3.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('dupeguru') %}

dupeguru-download-only:
  file.managed:
    - name: '{{ downloads }}\dupeguru\dupeGuru_win64_{{ version }}.exe'
    - source: https://github.com/arsenetar/dupeguru/releases/download/{{ version }}/dupeGuru_win64_{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
