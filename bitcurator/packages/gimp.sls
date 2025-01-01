# Name: gimp
# Website: https://www.gimp.org/downloads/
# Description: GNU Image Manipulation Program
# Category: Archival
# Author: Multiple (https://www.gimp.org/docs/userfaq.html#is-there-a-company-or-a-foundation-behind-gimp)
# License: GNU General Public License v3+ (https://www.gimp.org/docs/userfaq.html#whats-the-gimps-license-and-how-do-i-comply-with-it)
# Version: 2.10.38
# Notes: 

{% set version = '2.10.38' %}

include:
  - bitcurator.repos

gimp:
  pkg.installed
