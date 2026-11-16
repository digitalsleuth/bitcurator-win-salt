# Name: openrefine
# Website: https://openrefine.org/
# Description: Open source tool for working with messy data
# Category: Archival
# Author: OpenRefine
# License: BSD 3-Clause (https://github.com/OpenRefine/OpenRefine/blob/master/LICENSE.txt)
# Version: 3.10.1
# Notes: 

# renovate: datasource=github-releases depName=OpenRefine/OpenRefine
{% set version = '3.10.1' %}

include:
  - bitcurator.repos

openrefine:
  pkg.installed
