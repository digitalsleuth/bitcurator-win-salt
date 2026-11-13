# Name: Offline Staging
# Website: https://github.com/digitalsleuth/bitcurator-win-salt
# Description: Stages the BitCurator-WIN states and SaltStack for offline installation
# Category: Utilities
# Author: Corey Forman (digitalsleuth)
# License: GNU General Public License v3+
# Version: 0.0
# Notes: Copies the current states and the SaltStack directory alongside the downloads

{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.downloads.packages.saltstack

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
