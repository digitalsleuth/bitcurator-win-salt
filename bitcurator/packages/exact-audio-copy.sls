# Name: exact-audio-copy
# Website: https://www.exactaudiocopy.de/
# Description: 
# Category: Archival
# Author: Andre Wiethoff
# License: Free for private use (https://www.exactaudiocopy.de/en/index.php/resources/registration/)
# Version: 1.8
# Notes: 

{% set version = '1.8' %}

include:
  - bitcurator.packages.dotnetfx35

exact-audio-copy:
  pkg.installed:
    - require:
      - sls: bitcurator.packages.dotnetfx35
  
exact-audio-copy-del-shortcut:
  file.absent:
    - name: 'C:\Users\Public\Desktop\Exact Audio Copy.lnk'
    - require:
      - pkg: exact-audio-copy
