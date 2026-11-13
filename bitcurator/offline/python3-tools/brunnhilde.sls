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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'brunnhilde-' ~ version ~ '-py3-none-any.whl' %}
{% set exists = salt['file.file_exists'](downloads + '\\brunnhilde\\packages\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

brunnhilde-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages brunnhilde'
    - cwd: '{{ downloads }}\brunnhilde\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
