# Name: windirstat
# Website: https://windirstat.net/
# Description: Disk usage statistics viewer for Microsoft Windows
# Category: Archival
# Author: Multiple (https://github.com/windirstat/windirstat/blob/master/CONTRIBUTORS.md)
# License: GNU General Public License v2 (https://github.com/windirstat/windirstat/blob/master/LICENSE.md)
# Version: 2.1.1
# Notes: 

{% set version = '2.1.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '95020ad73627c39b798df70080e7c375612987910327a27a95e325077ca18ac0' %}

windirstat-download-only:
  file.managed:
    - name: '{{ downloads }}\windirstat\WinDirStat-x64-{{ version }}.msi'
    - source: https://github.com/windirstat/windirstat/releases/download/release/v{{ version }}/WinDirStat-x64.msi
    - source_hash: sha256={{ hash }}
    - makedirs: True
