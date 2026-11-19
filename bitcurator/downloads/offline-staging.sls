# Name: Offline Staging
# Website: https://github.com/digitalsleuth/bitcurator-win-salt
# Description: Stages the BitCurator-WIN states and SaltStack for offline installation
# Category: Utilities
# Author: Corey Forman (digitalsleuth)
# License: GNU General Public License v3+
# Version: 3.0.0
# Notes: Copies the current states and the SaltStack directory alongside the downloads

# renovate: datasource=github-releases depName=digitalsleuth/BitCurator-WIN
{% set version = '3.0.0' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('offline-staging') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

bitcurator-copy-current-states:
  file.copy:
    - name: '{{ downloads }}\offline\bitcurator'
    - source: 'C:\ProgramData\Salt Project\Salt\srv\salt\bitcurator'
    - subdir: True
    - makedirs: True
    - replace: True

bitcurator-copy-saltstack-directory:
  file.copy:
    - name: '{{ downloads }}\offline\Salt'
    - source: 'C:\Program Files\Salt Project\Salt'
    - subdir: True
    - makedirs: True
    - replace: True

bitcurator-download-current-bitcurator-win:
  file.managed:
    - name: '{{ downloads }}\offline\bitcurator-win-{{ version }}.exe'
    - source: https://github.com/digitalsleuth/bitcurator-win/releases/download/v{{ version }}/bitcurator-win-v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - require:
      - file: bitcurator-copy-current-states
      - file: bitcurator-copy-saltstack-directory
