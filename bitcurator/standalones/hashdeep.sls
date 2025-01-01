# Name: hashdeep
# Website: https://github.com/jessek/hashdeep
# Description: 
# Category: Archival
# Author: Jesse Kornblum
# License: GNU General Public License v2 (https://github.com/jessek/hashdeep/blob/master/COPYING)
# Version: 4.4
# Notes: 

{% set version = '4.4' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = 'd5e85933e74e5ba6a73f67346bc2e765075d26949c831a428166c92772f67dbc' %}

hashdeep-download:
  file.managed:
    - name: 'C:\salt\tempdownload\md5deep-{{ version }}.zip'
    - source: https://github.com/jessek/hashdeep/releases/download/v{{ version }}/md5deep-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

hashdeep-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\md5deep-{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: hashdeep-download

hashdeep-rename:
  file.rename:
    - name: '{{ inpath }}\hashdeep'
    - source: '{{ inpath }}\md5deep-{{ version }}'
    - force: True
    - require:
      - archive: hashdeep-extract

hashdeep-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\hashdeep\'
    - require:
      - file: hashdeep-rename
