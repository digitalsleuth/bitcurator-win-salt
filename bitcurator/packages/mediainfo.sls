# Name: mediainfo
# Website: https://mediaarea.net/en/MediaInfo/Download/Windows
# Description: Tool to display and manage metadata for media files
# Category: Archival
# Author: MediaArea
# License: Open Source / BSD-style (https://mediaarea.net/en/MediaInfo)
# Version: 24.12
# Notes: 

{% set version = '24.12' %}

include:
  - bitcurator.repos

mediainfo:
  pkg.installed
