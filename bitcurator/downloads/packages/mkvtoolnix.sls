# Name: mkvtoolnix
# Website: https://mkvtoolnix.download/
# Description: A set of tools to inspect, alter and create Matroska media files
# Category: Archival
# Author: Moritz Bunkus et al (https://gitlab.com/mbunkus/mkvtoolnix/-/blob/main/AUTHORS?ref_type=heads)
# License: GNU General Public License v2 (https://gitlab.com/mbunkus/mkvtoolnix/-/blob/main/COPYING?ref_type=heads)
# Version: 88.0
# Notes: 

{% set version = '88.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('mkvtoolnix') %}

mkvtoolnix-download-only:
  file.managed:
    - name: '{{ downloads }}\mkvtoolnix\mkvtoolnix-64-bit-{{ version }}-setup.exe'
    - source: https://mkvtoolnix.download/windows/releases/{{ version }}/mkvtoolnix-64-bit-{{ version }}-setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
