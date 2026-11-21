# Name: epadd
# Website: https://www.epaddproject.org/
# Description: 
# Category: Archival
# Author: Stanford University's Special Collections and University Archives
# License: Creative Commons Attribution 2.0 / Apache License v2.0 (https://github.com/ePADD/epadd/blob/main/README.md)
# Version: 11.1.4
# Notes: Will prompt for firewall access on first launch

{% set version = '11.1.4' %}

include:
  - bitcurator.repos

epadd:
  pkg.installed:
    - require:
      - sls: bitcurator.repos
