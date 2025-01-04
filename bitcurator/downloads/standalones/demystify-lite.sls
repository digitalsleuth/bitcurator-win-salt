# Name: demystify-lite
# Website: https://github.com/ross-spencer/demystify-lite
# Description: WASM based version of Demystify using pyscript
# Category: Archival
# Author: Ross Spencer
# License: GNU General Public License v3 (https://github.com/ross-spencer/demystify-lite/blob/main/LICENSE)
# Version: 0.0.0
# Notes: 

{% set version = '0.0.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

include:
  - bitcurator.packages.git

demystify-lite-clone-only:
  git.latest:
    - name: https://github.com/ross-spencer/demystify-lite
    - target: '{{ downloads }}\demystify-lite\demystify-lite'
    - rev: main
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git
