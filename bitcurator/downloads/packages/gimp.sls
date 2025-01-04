# Name: gimp
# Website: https://www.gimp.org/downloads/
# Description: GNU Image Manipulation Program
# Category: Archival
# Author: Multiple (https://www.gimp.org/docs/userfaq.html#is-there-a-company-or-a-foundation-behind-gimp)
# License: GNU General Public License v3+ (https://www.gimp.org/docs/userfaq.html#whats-the-gimps-license-and-how-do-i-comply-with-it)
# Version: 2.10.38
# Notes: 

{% set version = '2.10.38' %}
{% set major_version = '2.10' %}
{% set minor_version = '-1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'bdcf059c7d4e1b0ab59f8dc5f199ebb60ae0445460bf67ff8e4e438a89cee3d8' %}

gimp-download-only:
  file.managed:
    - name: '{{ downloads }}\gimp\gimp-{{ version }}-setup{{ minor_version }}.exe'
    - source: https://download.gimp.org/mirror/pub/gimp/v{{ major_version }}/windows/gimp-{{ version }}-setup{{ minor_version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
