# Name: brunnhilde
# Website: https://github.com/tw4l/brunnhilde
# Description: 
# Category: Archival
# Author: Tessa Walsh
# License: MIT License (https://github.com/tw4l/brunnhilde/blob/main/LICENSE)
# Version: 1.9.6
# Notes: GUI not yet ready for Windows - https://github.com/tw4l/brunnhilde-gui

# renovate: datasource=pypi depName=brunnhilde
{% set version = '1.9.6' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3

brunnhilde-folder-download-only:
  file.directory:
    - name: '{{ downloads }}\brunnhilde'
    - makedirs: True
    - force: True
    - win_inheritance: True

brunnhilde-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages brunnhilde'
    - cwd: '{{ downloads }}\brunnhilde\'
    - require:
      - sls: bitcurator.standalones.portable-python3
      - file: brunnhilde-folder-download-only
