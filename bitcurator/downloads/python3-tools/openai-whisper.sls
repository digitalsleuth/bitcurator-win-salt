# Name: openai-whisper
# Website: https://github.com/openai/whisper
# Description: Robust speech recognition model
# Category: Archival
# Author: OpenAI
# License: MIT License (https://github.com/openai/whisper/blob/main/LICENSE)
# Version: 20240930
# Notes: 

# renovate: datasource=pypi depName=openai-whisper
{% set version = '20240930' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3

openai-whisper-folder-download-only:
  file.directory:
    - name: '{{ downloads }}\openai-whisper'
    - makedirs: True
    - force: True
    - win_inheritance: True

openai-whisper-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages openai-whisper setuptools wheel'
    - cwd: '{{ downloads }}\openai-whisper\'
    - require:
      - sls: bitcurator.standalones.portable-python3
      - file: openai-whisper-folder-download-only
