# Name: Notepad++
# Website: https://notepad-plus-plus.org
# Description: Free source code / text editor
# Category: Documents / Editors
# Author: Don Ho
# License: GNU General Public License 2.0 (https://notepad-plus-plus.org/)
# Version: 8.8.3
# Notes: 

{% set version = '8.8.3' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '7094a07167648628e47249a16d9d6db922e5aa1255ac4322a2e4900d233372dd' %}

notepad-plus-plus-download-only:
  file.managed:
    - name: '{{ downloads }}\notepad-plus-plus\npp.{{ version }}.Installer.x64.exe'
    - source: https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v{{ version }}/npp.{{ version }}.Installer.x64.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
