# Name: ffmpeg
# Website: https://www.ffmpeg.org/
# Description: Framework and toolset to work with multimedia files
# Category: Archival
# Author: Fabrice Bellard et al (https://git.ffmpeg.org/gitweb/ffmpeg.git/blob_plain/HEAD:/MAINTAINERS)
# License: GNU Lesser General Public License v2.1 (https://git.ffmpeg.org/gitweb/ffmpeg.git/blob_plain/HEAD:/LICENSE.md)
# Version: 7.1
# Notes: ffmpeg, ffprobe, ffplay

{% set version = '7.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('ffmpeg') %}

include:
  - bitcurator.config.shims

ffmpeg-download:
  file.managed:
    - name: 'C:\salt\tempdownload\ffmpeg-{{ version }}-full_build.zip'
    - source: https://github.com/GyanD/codexffmpeg/releases/download/{{ version }}/ffmpeg-{{ version }}-full_build.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

ffmpeg-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: 'C:\salt\tempdownload\ffmpeg-{{ version }}-full_build.zip'
    - enforce_toplevel: False
    - require:
      - file: ffmpeg-download

ffmpeg-rename:
  file.rename:
    - name: '{{ inpath }}\ffmpeg'
    - source: '{{ inpath }}\ffmpeg-{{ version }}-full_build'
    - force: True
    - require:
      - archive: ffmpeg-extract

{% for exe in ['ffmpeg', 'ffplay', 'ffprobe'] %}
{{ exe }}-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\ffmpeg\bin\{{ exe }}.exe -OutPath {{ inpath }}\shims\{{ exe }}.exe'
    - require:
      - file: ffmpeg-rename
      - sls: bitcurator.config.shims
{% endfor %}
