# Name: dupeguru
# Website: https://dupeguru.voltaicideas.net/
# Description: Cross-platform tool to find duplicate files in a system
# Category: Archival
# Author: Andrew Senetar
# License: GNU General Public License v3 (https://github.com/arsenetar/dupeguru/blob/master/LICENSE)
# Version: 4.3.1
# Notes: 

# renovate: datasource=github-releases depName=arsenetar/dupeguru
{% set version = '4.3.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'dupeGuru_win64_' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\dupeguru\\' + pkg) %}

{% if exists %}

dupeguru-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\dupeguru\{{ pkg }}" /S /ALLUSERS'
    - shell: cmd
    - cwd: '{{ downloads }}\dupeguru\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
