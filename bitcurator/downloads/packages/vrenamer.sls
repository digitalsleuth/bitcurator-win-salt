# Name: vrenamer
# Website: https://vrenamer.com/
# Description: Mass renaming software
# Category: Archival
# Author: Carlos Verdier
# License: GNU General Public License v3 (https://sourceforge.net/projects/vrenamer/)
# Version: 1.6.1
# Notes: 

{% set version = '1.6.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '8b3ce5eac092901327fbf24311daa161236f3cbd6ec998ff8d992c45657d2028' %}

vrenamer-download-only:
  file.managed:
    - name: '{{ downloads }}\vrenamer\vRenamer_{{ version | replace(".","") }}_setup.exe'
    - source: https://phoenixnap.dl.sourceforge.net/project/vrenamer/{{ version }}/vRenamer_{{ version | replace(".","") }}_setup.exe?viasf=1
    - source_hash: sha256={{ hash }}
    - makedirs: True
