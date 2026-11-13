# Name: ffmpeg
# Website: https://www.ffmpeg.org/
# Description: Framework and toolset to work with multimedia files
# Category: Archival
# Author: Fabrice Bellard et al (https://git.ffmpeg.org/gitweb/ffmpeg.git/blob_plain/HEAD:/MAINTAINERS)
# License: GNU Lesser General Public License v2.1 (https://git.ffmpeg.org/gitweb/ffmpeg.git/blob_plain/HEAD:/LICENSE.md)
# Version: 7.1
# Notes: ffmpeg, ffprobe, ffplay

{% set version = '7.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('ffmpeg') %}

ffmpeg-download-only:
  file.managed:
    - name: '{{ downloads }}\ffmpeg\ffmpeg-{{ version }}-full_build.zip'
    - source: https://github.com/GyanD/codexffmpeg/releases/download/{{ version }}/ffmpeg-{{ version }}-full_build.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
