# Name: powergrep
# Website: https://www.powergrep.com/
# Description: Graphical GREP tool for Windows
# Category: Archival
# Author: Jan Goyvaerts
# License: Free Trial
# Version: 5.4.2
# Notes: 

{% set version = '5.4.2' %}

include:
  - bitcurator.repos

powergrep:
  pkg.installed

powergrep-del-shortcut:
  file.absent:
    - name: 'C:\Users\Public\Desktop\PowerGREP 5.lnk'
    - require:
      - pkg: powergrep
