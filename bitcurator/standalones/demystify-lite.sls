# Name: demystify-lite
# Website: https://github.com/ross-spencer/demystify-lite
# Description: WASM based version of Demystify using pyscript
# Category: Archival
# Author: Ross Spencer
# License: GNU General Public License v3 (https://github.com/ross-spencer/demystify-lite/blob/main/LICENSE)
# Version: 0.0.0
# Notes: 

{% set version = '0.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - bitcurator.packages.git

demystify-lite-clone:
  git.latest:
    - name: https://github.com/ross-spencer/demystify-lite
    - target: '{{ inpath }}\demystify-lite'
    - rev: main
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git

demystify-lite-wrapper:
  file.managed:
    - name: '{{ inpath }}\demystify-lite\demystify-lite.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'cd {{ inpath }}\demystify-lite\ && start http://localhost:8000 && python3 -m http.server'
    - require:
      - git: demystify-lite-clone

demystify-lite-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\demystify-lite\'
    - require:
      - file: demystify-lite-wrapper

demystify-lite-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Demystify-Lite.lnk'
    - target: '{{ inpath }}\demystify-lite\demystify-lite.cmd'
    - force: True
    - working_dir: '{{ inpath }}\demystify-lite\'
    - icon_location: '{{ inpath }}\demystify-lite\demystify.ico'
    - makedirs: True
    - require:
      - win_path: demystify-lite-env-vars
