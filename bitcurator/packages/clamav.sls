# Name: clamav
# Website: https://www.clamav.net/
# Description: Open source anti-virus scanner
# Category: Archival
# Author: https://www.clamav.net/about
# License: GNU General Public License v2 (https://github.com/Cisco-Talos/clamav/blob/main/COPYING.txt)
# Version: 1.4.1
# Notes: 

{% set version = '1.4.1' %}

include:
  - bitcurator.repos

clamav:
  pkg.installed
