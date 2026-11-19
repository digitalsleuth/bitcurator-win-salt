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
  cmd.run:
    - name: 'robocopy "C:\ProgramData\Salt Project\Salt\srv\salt\bitcurator" "{{ downloads }}\offline\bitcurator" /E /XJ /R:1 /W:1 /NFL /NDL /NJH /NP'
    - shell: cmd
    - success_retcodes: [1, 2, 3, 4, 5, 6, 7]

bitcurator-copy-saltstack-directory:
  cmd.run:
    - name: 'robocopy "C:\Program Files\Salt Project\Salt" "{{ downloads }}\offline\Salt" /E /XJ /R:1 /W:1 /NFL /NDL /NJH /NP'
    - shell: cmd
    - success_retcodes: [1, 2, 3, 4, 5, 6, 7]

bitcurator-download-current-bitcurator-win:
  file.managed:
    - name: '{{ downloads }}\offline\bitcurator-win-{{ version }}.exe'
    - source: https://github.com/digitalsleuth/bitcurator-win/releases/download/v{{ version }}/bitcurator-win-v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - require:
      - cmd: bitcurator-copy-current-states
      - cmd: bitcurator-copy-saltstack-directory
