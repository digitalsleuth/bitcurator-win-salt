# Name: dvd-transcoder
# Website: https://github.com/digitalsleuth/videomachine
# Description: Python script to convert DVD ISO files to various formats
# Category: Archival
# Author: Bay Area Video Coalition and Corey Forman
# License: None
# Version: 2.0.0
# Notes: Requires ffmpeg, mediainfo cli optional

{% set version = '2.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = '15e2d235446d5d1daafa7087ce4155d49f9b1df27429c5ae737173a100becea8' %}

include:
  - bitcurator.packages.python3
  - bitcurator.standalones.ffmpeg
  - bitcurator.standalones.mediainfo-cli

dvd-transcoder-download:
  file.managed:
    - name: '{{ inpath }}\dvd-transcoder\dvd_transcoder.py'
    - source: 'https://github.com/digitalsleuth/videomachine/raw/refs/heads/master/dvd_transcoder.py'
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - require:
      - sls: bitcurator.packages.python3
      - sls: bitcurator.standalones.ffmpeg
      - sls: bitcurator.standalones.mediainfo-cli

dvd-transcoder-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\dvd-transcoder\'
    - require:
      - file: dvd-transcoder-download
