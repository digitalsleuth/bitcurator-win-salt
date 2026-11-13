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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'dvd-transcoder-' ~ version ~ '.py' %}
{% set exists = salt['file.file_exists'](downloads + '\\dvd-transcoder\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3
  - bitcurator.offline.standalones.ffmpeg
  - bitcurator.offline.standalones.mediainfo-cli

dvd-transcoder-offline:
  file.managed:
    - name: '{{ inpath }}\dvd-transcoder\dvd_transcoder.py'
    - source: '{{ downloads }}\dvd-transcoder\{{ pkg }}'
    - skip_verify: True
    - makedirs: True
    - require:
      - sls: bitcurator.offline.packages.python3
      - sls: bitcurator.offline.standalones.ffmpeg
      - sls: bitcurator.offline.standalones.mediainfo-cli

dvd-transcoder-env-vars-offline:
  win_path.exists:
    - name: '{{ inpath }}\dvd-transcoder\'
    - require:
      - file: dvd-transcoder-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
