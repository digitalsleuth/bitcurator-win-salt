# Name: advanced-renamer
# Website: https://www.advancedrenamer.com/
# Description: 
# Category: Archival
# Author: Kim Jensen (https://www.advancedrenamer.com/about)
# License: https://advancedrenamer.com/license
# Version: 4.06
# Notes: 

{% set version = '4.06' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'ff267ad788b69c26cc3a60385f222f318efb5707c00cf44a8756aff6541801f3' %}

advanced-renamer-download-only:
  file.managed:
    - name: '{{ downloads }}\advanced-renamer\advanced_renamer_setup_{{ version }}.exe'
    - source: https://www.advancedrenamer.com/down/win/advanced_renamer_setup_{{ version | replace(".", "_") }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
