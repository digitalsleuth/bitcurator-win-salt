# Name: Eclipse Temurin
# Website: https://adoptium.net/temurin/
# Description: Open JDK by Adoptium
# Category: Archival
# Author: Adoptium
# License: Eclipse Public License v2 (https://www.eclipse.org/legal/epl-2.0/)
# Version: 21.0.5
# Notes: 

{% set version = '21.0.5' %}
{% set subversion = '11' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '8ef78a37811529d73d37e29a9fa24bf2d46d0d5d97c4f6e403ea9adebc55eaf3' %}

openjdk-adoptium-download-only:
  file.managed:
    - name: '{{ downloads }}\openjdk-adoptium\OpenJDK21U-jdk_x64_windows_hotspot_{{ version }}_{{ subversion}}.msi'
    - source: https://github.com/adoptium/temurin21-binaries/releases/download/jdk-{{ version }}%2B{{ subversion }}/OpenJDK21U-jdk_x64_windows_hotspot_{{ version }}_{{ subversion }}.msi
    - source_hash: sha256={{ hash }}
    - makedirs: True
