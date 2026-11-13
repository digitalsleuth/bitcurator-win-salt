# Name: Eclipse Temurin
# Website: https://adoptium.net/temurin/
# Description: Open JDK by Adoptium
# Category: Archival
# Author: Adoptium
# License: Eclipse Public License v2 (https://www.eclipse.org/legal/epl-2.0/)
# Version: 21.0.5
# Notes: 

# renovate: datasource=github-releases depName=adoptium/temurin21-binaries
{% set version = '21.0.5' %}
{% set major = '21' %}
{% set subversion = '11' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('openjdk-adoptium') %}

openjdk-adoptium-download-only:
  file.managed:
    - name: '{{ downloads }}\openjdk-adoptium\openjdk-adoptium-{{ version }}.msi'
    - source: https://github.com/adoptium/temurin{{ major }}-binaries/releases/download/jdk-{{ version }}%2B{{ subversion }}/OpenJDK{{ major }}U-jdk_x64_windows_hotspot_{{ version }}_{{ subversion }}.msi
    - source_hash: sha256={{ hash }}
    - makedirs: True
