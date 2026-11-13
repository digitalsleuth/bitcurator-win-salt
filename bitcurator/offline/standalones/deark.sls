# Name: deark
# Website: https://entropymine.com/deark/
# Description: Portable command-line utility to decode file types
# Category: Archival
# Author: Jason Summers
# License: MIT (https://github.com/jsummers/deark/blob/master/COPYING)
# Version: 1.6.8
# Notes:

{% set version = '1.6.8' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'deark-' ~ version ~ '.tar.gz' %}
{% set exists = salt['file.file_exists'](downloads + '\\deark\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.7zip
  - bitcurator.config.shims

deark-extract-offline:
  cmd.run:
    - name: '"C:\Program Files\7-Zip\7z.exe" x {{ downloads }}\deark\{{ pkg }} -o"{{ inpath }}\" -y && "C:\Program Files\7-Zip\7z.exe" x {{ inpath }}\deark-{{ version }}.tar -o"{{ inpath }}\"'
    - shell: cmd

deark-delete-tar-offline:
  file.absent:
    - name: '{{ inpath }}\deark-{{ version }}.tar'
    - require:
      - cmd: deark-extract-offline

deark-folder-rename-offline:
  file.rename:
    - name: '{{ inpath }}\deark'
    - source: '{{ inpath }}\deark-{{ version }}\'
    - force: True
    - require:
      - cmd: deark-extract-offline

deark-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\deark\x64\deark.exe -OutPath {{ inpath }}\shims\deark.exe'
    - require:
      - file: deark-folder-rename-offline
      - sls: bitcurator.config.shims

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
