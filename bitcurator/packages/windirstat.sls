# Name: windirstat
# Website: https://windirstat.net/
# Description: Disk usage statistics viewer for Microsoft Windows
# Category: Archival
# Author: Multiple (https://github.com/windirstat/windirstat/blob/master/CONTRIBUTORS.md)
# License: GNU General Public License v2 (https://github.com/windirstat/windirstat/blob/master/LICENSE.md)
# Version: 2.1.1
# Notes: 

{% set version = '2.1.1' %}

include:
  - bitcurator.repos

windirstat:
  pkg.installed
