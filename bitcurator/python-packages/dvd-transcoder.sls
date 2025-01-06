# Name: dvd-transcoder
# Website: https://github.com/digitalsleuth/videomachine
# Description: Python script to convert DVD ISO files to various formats
# Category: Archival
# Author: Bay Area Video Coalition and Corey Forman
# License: None
# Version: 2.1.0
# Notes: Requires ffmpeg, mediainfo cli optional

{% set version = '2.1.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = 'c46bf22078cd91998417c45d06d743f7f3b0666105efa9f285e4cec2882a8f68' %}

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
