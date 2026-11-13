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
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'openjdk-adoptium-' ~ version ~ '.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\openjdk-adoptium\\' + pkg) %}

{% if exists %}

openjdk-adoptium-install-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\openjdk-adoptium\{{ pkg }}" /qn /norestart'
    - shell: cmd
    - cwd: '{{ downloads }}\openjdk-adoptium\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
