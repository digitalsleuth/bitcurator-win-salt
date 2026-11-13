# Name: dupeguru
# Website: https://dupeguru.voltaicideas.net/
# Description: Cross-platform tool to find duplicate files in a system
# Category: Archival
# Author: Andrew Senetar
# License: GNU General Public License v3 (https://github.com/arsenetar/dupeguru/blob/master/LICENSE)
# Version: 4.3.1
# Notes: 

# renovate: datasource=github-releases depName=arsenetar/dupeguru
{% set version = '4.3.1' %}

include:
  - bitcurator.repos

dupeguru:
  pkg.installed
