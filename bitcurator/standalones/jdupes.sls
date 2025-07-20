# Name: jdupes
# Website: https://codeberg.org/jbruchon/jdupes
# Description: File de-duplication software
# Category: Archival
# Author: Jody Bruchon
# License: MIT License (https://codeberg.org/jbruchon/jdupes/src/branch/master/LICENSE.txt)
# Version: 1.28.0
# Notes: 

{% set version = '1.28.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = 'e212e9ddb5054809841af3bf5cf162fe520076a96665041d1a0843170aa27f32' %}

jdupes-download:
  file.managed:
    - name: 'C:\salt\tempdownload\jdupes-{{ version }}-win64.zip'
    - source: https://codeberg.org/jbruchon/jdupes/releases/download/v{{ version }}/jdupes-{{ version }}-win64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

jdupes-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\jdupes-{{ version }}-win64.zip'
    - enforce_toplevel: False
    - require:
      - file: jdupes-download

jdupes-rename:
  file.rename:
    - name: '{{ inpath }}\jdupes'
    - source: '{{ inpath }}\jdupes-{{ version }}-win64'
    - force: True
    - require:
      - archive: jdupes-extract

jdupes-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\jdupes'
    - require:
      - file: jdupes-rename
