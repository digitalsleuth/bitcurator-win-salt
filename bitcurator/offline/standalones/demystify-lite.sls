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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set exists = salt['file.directory_exists'](downloads + '\\demystify-lite\\demystify-lite') %}

{% if exists %}

include:
  - bitcurator.config.shims

demystify-lite-copy-offline:
  file.copy:
    - name: '{{ inpath }}\demystify-lite'
    - source: '{{ downloads }}\demystify-lite\demystify-lite'
    - subdir: True
    - makedirs: True
    - force: True

demystify-lite-wrapper-offline:
  file.managed:
    - name: '{{ inpath }}\demystify-lite\demystify-lite.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'cd {{ inpath }}\demystify-lite\ && start http://localhost:8000 && python3 -m http.server'
    - require:
      - file: demystify-lite-copy-offline

demystify-lite-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\demystify-lite\demystify-lite.cmd -OutPath {{ inpath }}\shims\demystify-lite.exe'
    - require:
      - file: demystify-lite-wrapper-offline
      - sls: bitcurator.config.shims

demystify-lite-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Demystify-Lite.lnk'
    - target: '{{ inpath }}\demystify-lite\demystify-lite.cmd'
    - force: True
    - working_dir: '{{ inpath }}\demystify-lite\'
    - icon_location: '{{ inpath }}\demystify-lite\demystify.ico'
    - makedirs: True
    - require:
      - cmd: demystify-lite-shim-offline

{% else %}
{{ downloads }}\demystify-lite\demystify-lite does not exist - not installing:
  test.nop
{% endif %}
