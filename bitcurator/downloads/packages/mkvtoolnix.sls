# Name: mkvtoolnix
# Website: https://mkvtoolnix.download/
# Description: A set of tools to inspect, alter and create Matroska media files
# Category: Archival
# Author: Moritz Bunkus et al (https://gitlab.com/mbunkus/mkvtoolnix/-/blob/main/AUTHORS?ref_type=heads)
# License: GNU General Public License v2 (https://gitlab.com/mbunkus/mkvtoolnix/-/blob/main/COPYING?ref_type=heads)
# Version: 88.0
# Notes: 

{% set version = '88.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '1b685cbeb4b05e7cc342c92914486bd71a7ab0bfeb577106db94abfb9771da5a' %}

mkvtoolnix-download-only:
  file.managed:
    - name: '{{ downloads }}\mkvtoolnix\mkvtoolnix-64-bit-{{ version }}-setup.exe'
    - source: https://mkvtoolnix.download/windows/releases/{{ version }}/mkvtoolnix-64-bit-{{ version }}-setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
