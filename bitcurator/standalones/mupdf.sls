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
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('mupdf') %}

include:
  - bitcurator.config.shims

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

{% for exe in ['mupdf', 'mupdf-gl', 'mutool'] %}
{{ exe }}-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\mupdf\{{ exe }}.exe -OutPath {{ inpath }}\shims\{{ exe }}.exe'
    - require:
      - file: mupdf-rename
      - sls: bitcurator.config.shims
{% endfor %}
