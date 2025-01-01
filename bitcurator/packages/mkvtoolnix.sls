# Name: mkvtoolnix
# Website: https://mkvtoolnix.download/
# Description: A set of tools to inspect, alter and create Matroska media files
# Category: Archival
# Author: Moritz Bunkus et al (https://gitlab.com/mbunkus/mkvtoolnix/-/blob/main/AUTHORS?ref_type=heads)
# License: GNU General Public License v2 (https://gitlab.com/mbunkus/mkvtoolnix/-/blob/main/COPYING?ref_type=heads)
# Version: 88.0
# Notes: 

{% set version = '88.0' %}

include:
  - bitcurator.repos

mkvtoolnix:
  pkg.installed
