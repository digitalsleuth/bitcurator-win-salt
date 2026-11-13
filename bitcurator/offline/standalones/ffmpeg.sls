# Name: ffmpeg
# Website: https://www.ffmpeg.org/
# Description: Framework and toolset to work with multimedia files
# Category: Archival
# Author: Fabrice Bellard et al (https://git.ffmpeg.org/gitweb/ffmpeg.git/blob_plain/HEAD:/MAINTAINERS)
# License: GNU Lesser General Public License v2.1 (https://git.ffmpeg.org/gitweb/ffmpeg.git/blob_plain/HEAD:/LICENSE.md)
# Version: 7.1
# Notes: ffmpeg, ffprobe, ffplay

# renovate: datasource=github-releases depName=GyanD/codexffmpeg
{% set version = '7.1' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'ffmpeg-' ~ version ~ '-full_build.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\ffmpeg\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.shims

ffmpeg-extract-offline:
  archive.extracted:
    - name: '{{ inpath }}\'
    - source: '{{ downloads }}\ffmpeg\{{ pkg }}'
    - enforce_toplevel: False

ffmpeg-rename-offline:
  file.rename:
    - name: '{{ inpath }}\ffmpeg'
    - source: '{{ inpath }}\ffmpeg-{{ version }}-full_build'
    - force: True
    - require:
      - archive: ffmpeg-extract-offline

{% for exe in ['ffmpeg', 'ffplay', 'ffprobe'] %}
{{ exe }}-shim-offline:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\ffmpeg\bin\{{ exe }}.exe -OutPath {{ inpath }}\shims\{{ exe }}.exe'
    - require:
      - file: ffmpeg-rename-offline
      - sls: bitcurator.config.shims
{% endfor %}

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
