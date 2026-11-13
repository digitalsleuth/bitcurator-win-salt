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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'mupdf-' ~ version ~ '-windows.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\mupdf\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

mupdf-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: '{{ downloads }}\mupdf\{{ pkg }}'
    - enforce_toplevel: True
    - overwrite: True

mupdf-rename-offline:
  file.rename:
    - name: '{{ inpath }}\mupdf'
    - source: '{{ inpath }}\mupdf-{{ version }}-windows'
    - force: True
    - require:
      - archive: mupdf-extract-offline

mupdf-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\mupdf.lnk'
    - target: '{{ inpath }}\mupdf\mupdf.exe'
    - force: True
    - working_dir: '{{ inpath }}\mupdf\'
    - makedirs: True
    - require:
      - file: mupdf-rename-offline

{% for exe in ['mupdf', 'mupdf-gl', 'mutool'] %}
{{ exe }}-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\mupdf\{{ exe }}.exe -OutPath {{ inpath }}\shims\{{ exe }}.exe'
    - require:
      - file: mupdf-rename-offline
      - sls: bitcurator.config.shims
{% endfor %}

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
