# Name: windirstat
# Website: https://windirstat.net/
# Description: Disk usage statistics viewer for Microsoft Windows
# Category: Archival
# Author: Multiple (https://github.com/windirstat/windirstat/blob/master/CONTRIBUTORS.md)
# License: GNU General Public License v2 (https://github.com/windirstat/windirstat/blob/master/LICENSE.md)
# Version: 2.1.1
# Notes: 

# renovate: datasource=github-releases depName=windirstat/windirstat
{% set version = '2.1.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('windirstat') %}

windirstat-download-only:
  file.managed:
    - name: '{{ downloads }}\windirstat\WinDirStat-x64-{{ version }}.msi'
    - source: https://github.com/windirstat/windirstat/releases/download/release/v{{ version }}/WinDirStat-x64.msi
    - source_hash: sha256={{ hash }}
    - makedirs: True
