# Name: Eclipse Temurin
# Website: https://adoptium.net/temurin/
# Description: Open JDK by Adoptium
# Category: Archival
# Author: Adoptium
# License: Eclipse Public License v2 (https://www.eclipse.org/legal/epl-2.0/)
# Version: 21.0.5
# Notes: 

{% set version = '21.0.5' %}

include:
  - bitcurator.repos

openjdk-adoptium:
  pkg.installed
