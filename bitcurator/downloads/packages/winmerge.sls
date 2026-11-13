# Name: WinMerge
# Website: https://winmerge.org
# Description: File Differencing Tool
# Category: Archival
# Author: Dean P. Grimm (Thingamahoocie Software)
# License: GNU General Public License v2.0 (https://github.com/WinMerge/winmerge/blob/master/LICENSE.md)
# Version: 2.16.44
# Notes:

{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set version = '2.16.44' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('winmerge') %}

winmerge-download-only:
  file.managed:
    - name: '{{ downloads }}\winmerge\WinMerge-{{ version }}-x64-Setup.exe'
    - source: https://github.com/WinMerge/winmerge/releases/download/v{{ version }}/WinMerge-{{ version }}-x64-Setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
