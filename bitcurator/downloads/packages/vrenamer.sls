# Name: vrenamer
# Website: https://vrenamer.com/
# Description: Mass renaming software
# Category: Archival
# Author: Carlos Verdier
# License: GNU General Public License v3 (https://sourceforge.net/projects/vrenamer/)
# Version: 1.6.1
# Notes: 

{% set version = '1.6.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('vrenamer') %}

vrenamer-download-only:
  file.managed:
    - name: '{{ downloads }}\vrenamer\vRenamer_{{ version | replace(".","") }}_setup.exe'
    - source: https://phoenixnap.dl.sourceforge.net/project/vrenamer/{{ version }}/vRenamer_{{ version | replace(".","") }}_setup.exe?viasf=1
    - source_hash: sha256={{ hash }}
    - makedirs: True
