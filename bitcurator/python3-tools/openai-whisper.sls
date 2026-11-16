# Name: openai-whisper
# Website: https://github.com/openai/whisper
# Description: Robust speech recognition model
# Category: Archival
# Author: OpenAI
# License: MIT License (https://github.com/openai/whisper/blob/main/LICENSE)
# Version: 20250625
# Notes: 

# renovate: datasource=pypi depName=openai-whisper
{% set version = '20250625' %}

include:
  - bitcurator.packages.python3

openai-whisper-install:
  pip.installed:
    - name: openai-whisper
    - bin_env: 'C:\Program Files\Python311\python.exe'
    - require:
      - sls: bitcurator.packages.python3

