# Name: Bulk Extractor
# Website: https://digitalcorpora.org/downloads/bulk_extractor & https://github.com/simsong/bulk_extractor
# Description: Tool for extracting artifacts from random data
# Category: Archival
# Author: Simson L. Garfinkel
# License: MIT License (https://github.com/simsong/bulk_extractor/blob/main/LICENSE.md)
# Version: 1.5.5
# Notes:

{% set version = '1.5.5' %}

include:
  - bitcurator.repos

bulk-extractor:
  pkg.installed
