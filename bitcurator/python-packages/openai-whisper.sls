# Name: openai-whisper
# Website: https://github.com/openai/whisper
# Description: Robust speech recognition model
# Category: Archival
# Author: OpenAI
# License: MIT License (https://github.com/openai/whisper/blob/main/LICENSE)
# Version: 20240930
# Notes: 

{% set version = '20240930' %}

include:
  - bitcurator.packages.python3

openai-whisper-install:
  pip.installed:
    - name: openai-whisper
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: bitcurator.packages.python3

