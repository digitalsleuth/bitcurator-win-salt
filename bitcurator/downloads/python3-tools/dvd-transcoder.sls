# Name: dvd-transcoder
# Website: https://github.com/digitalsleuth/videomachine
# Description: Python script to convert DVD ISO files to various formats
# Category: Archival
# Author: Bay Area Video Coalition and Corey Forman
# License: None
# Version: 2.1.0
# Notes: Requires ffmpeg, mediainfo cli optional

{% set version = '2.1.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('dvd-transcoder') %}

dvd-transcoder-download-only:
  file.managed:
    - name: '{{ downloads }}\dvd-transcoder\dvd-transcoder-{{ version }}.py'
    - source: 'https://github.com/digitalsleuth/videomachine/raw/refs/heads/master/dvd_transcoder.py'
    - source_hash: sha256={{ hash }}
    - makedirs: True
