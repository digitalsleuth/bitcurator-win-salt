# Name: mkvtoolnix
# Website: https://mkvtoolnix.download/
# Description: A set of tools to inspect, alter and create Matroska media files
# Category: Archival
# Author: Moritz Bunkus et al (https://gitlab.com/mbunkus/mkvtoolnix/-/blob/main/AUTHORS?ref_type=heads)
# License: GNU General Public License v2 (https://gitlab.com/mbunkus/mkvtoolnix/-/blob/main/COPYING?ref_type=heads)
# Version: 88.0
# Notes: 

{% set version = '88.0' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'mkvtoolnix-64-bit-' ~ version ~ '-setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\mkvtoolnix\\' + pkg) %}

{% if exists %}

mkvtoolnix-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\mkvtoolnix\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\mkvtoolnix\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
