# Name: VLC Media Player
# Website: https://www.videolan.org/
# Description: Media Player
# Category: Utilities
# Author: VideoLAN
# License: GNU General Public License v2 (https://www.videolan.org/legal.html)
# Version: 3.0.21
# Notes: 

{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set version = '3.0.21' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('vlc') %}

vlc-download-only:
  file.managed:
    - name: '{{ downloads }}\vlc\vlc-{{ version }}-win64.exe'
    - source: https://get.videolan.org/vlc/{{ version }}/win64/vlc-{{ version }}-win64.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
