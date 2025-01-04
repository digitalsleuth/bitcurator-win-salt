# Name: clamav
# Website: https://www.clamav.net/
# Description: Open source anti-virus scanner
# Category: Archival
# Author: https://www.clamav.net/about
# License: GNU General Public License v2 (https://github.com/Cisco-Talos/clamav/blob/main/COPYING.txt)
# Version: 1.4.1
# Notes: 

{% set version = '1.4.1' %}
{% set hash = '3d28bfddffef323583a20ac1c257801e6405ea68fba661b81c5cbec4560eaffa' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

clamav-download-only:
  file.managed:
    - name: '{{ downloads }}\clamav\clamav-{{ version }}.win.x64.msi'
    - source: https://www.clamav.net/downloads/production/clamav-{{ version }}.win.x64.msi
    - source_hash: sha256={{ hash }}
    - makedirs: True
