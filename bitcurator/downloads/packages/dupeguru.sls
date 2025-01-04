# Name: dupeguru
# Website: https://dupeguru.voltaicideas.net/
# Description: Cross-platform tool to find duplicate files in a system
# Category: Archival
# Author: Andrew Senetar
# License: GNU General Public License v3 (https://github.com/arsenetar/dupeguru/blob/master/LICENSE)
# Version: 4.3.1
# Notes: 

{% set version = '4.3.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '28293dada3c88336b2b53aca00adf59f85cabf1362f8386a8ffc6be5e1742836' %}

dupeguru-download-only:
  file.managed:
    - name: '{{ downloads }}\dupeguru\dupeGuru_win64_{{ version }}.exe'
    - source: https://github.com/arsenetar/dupeguru/releases/download/{{ version }}/dupeGuru_win64_{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
