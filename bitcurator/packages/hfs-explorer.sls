# Name: hfs-explorer
# Website: https://www.catacombae.org/hfsexplorer/
# Description: An application for accessing HFS/HFS+/HFSX file systems
# Category: Archival
# Author: Erik Larsson
# License: GNU General Public License v3+ (https://github.com/unsound/hfsexplorer/blob/master/doc/gpl.txt)
# Version: 2021.10.9
# Notes: 

{% set version = '2021.10.9' %}

include:
  - bitcurator.repos

hfs-explorer:
  pkg.installed
