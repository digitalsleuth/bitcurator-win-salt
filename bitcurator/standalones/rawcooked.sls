# Name: rawcooked
# Website: https://mediaarea.net/RAWcooked
# Description: Encodes RAW audio/visual sequences into a lossless video stream
# Category: Archival
# Author: MediaArea
# License: BSD 2-Clause license (https://mediaarea.net/RAWcooked)
# Version: 24.11
# Notes: 

{% set version = '24.11' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = '8698beb2ab09da36fe745f3d46a901829d83bf8466abae5c49a189184be06c1f' %}

include:
  - bitcurator.standalones.ffmpeg

rawcooked-download:
  file.managed:
    - name: 'C:\salt\tempdownload\RAWcooked_CLI_{{ version }}_Windows_x64.zip'
    - source: https://mediaarea.net/download/binary/rawcooked/{{ version }}/RAWcooked_CLI_{{ version }}_Windows_x64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

rawcooked-extract:
  archive.extracted:
    - name: '{{ inpath }}\rawcooked'
    - source: 'C:\salt\tempdownload\RAWcooked_CLI_{{ version }}_Windows_x64.zip'
    - enforce_toplevel: False
    - overwrite: True
    - require:
      - file: rawcooked-download

rawcooked-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\rawcooked'
    - require:
      - archive: rawcooked-extract
