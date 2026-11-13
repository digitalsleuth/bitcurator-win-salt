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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exists = salt['file.directory_exists'](downloads + '\\openai-whisper\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

openai-whisper-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages openai-whisper'
    - cwd: '{{ downloads }}\openai-whisper\'
    - require:
      - sls: bitcurator.offline.packages.python3

{% else %}
{{ downloads }}\openai-whisper\packages does not exist - not installing:
  test.nop
{% endif %}
