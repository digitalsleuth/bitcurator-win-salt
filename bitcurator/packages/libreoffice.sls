# Name: libreoffice
# Website: https://www.libreoffice.org/download/download-libreoffice/
# Description: Open source Office-like document suite
# Category: Documents / Editors
# Author: The Document Foundation
# License: Free Software - Multiple (https://www.libreoffice.org/about-us/licenses)
# Version: 24.8.4.2
# Notes: 

{% set version = '24.8.4.2' %}

include:
  - bitcurator.repos

libreoffice:
  pkg.installed
