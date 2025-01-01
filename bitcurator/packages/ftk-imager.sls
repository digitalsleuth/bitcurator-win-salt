# Name: FTK Imager
# Website: https://www.exterro.com
# Description: Forensic Image Acquisition and Triage tool
# Category: Archival
# Author: Exterro Inc / AccessData
# License: EULA
# Version: 4.7.3.81
# Notes:

{% set version = '4.7.3.81' %}

include:
  - bitcurator.repos

ftk-imager:
  pkg.installed

ftk-imager-del-shortcut:
  file.absent:
    - name: 'C:\Users\Public\Desktop\Exterro FTK Imager.lnk'
    - require:
      - pkg: ftk-imager
