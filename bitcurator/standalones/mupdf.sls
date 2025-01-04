# Name: mupdf
# Website: https://www.mupdf.com
# Description: Open source framework for viewing and converting PDF, XPS, and E-Book documents.
# Category: Archival
# Author: Multiple (https://github.com/ArtifexSoftware/mupdf/blob/master/CONTRIBUTORS)
# License: GNU Affero General Public License v3 (https://github.com/ArtifexSoftware/mupdf/blob/master/COPYING)
# Version: 1.25.2
# Notes: 

{% set version = '1.25.2' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set hash = '8cdd89ab8e638e7fd9e2ae3e75dd980aafe507bea63ad7a2eeaff1be403fff8c' %}

mupdf-download:
  file.managed:
    - name: 'C:\salt\tempdownload\mupdf-{{ version }}-windows.zip'
    - source: https://mupdf.com/downloads/archive/mupdf-{{ version }}-windows.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

mupdf-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\mupdf-{{ version }}-windows.zip'
    - enforce_toplevel: True
    - overwrite: True
    - require:
      - file: mupdf-download

mupdf-rename:
  file.rename:
    - name: '{{ inpath }}\mupdf'
    - source: '{{ inpath }}\mupdf-{{ version }}-windows'
    - force: True
    - require:
      - archive: mupdf-extract

mupdf-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\mupdf.lnk'
    - target: '{{ inpath }}\mupdf\mupdf.exe'
    - force: True
    - working_dir: '{{ inpath }}\mupdf\'
    - makedirs: True
    - require:
      - file: mupdf-rename

mupdf-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\mupdf'
    - require:
      - file: mupdf-rename
