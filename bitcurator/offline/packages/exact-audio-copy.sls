# Name: exact-audio-copy
# Website: https://www.exactaudiocopy.de/
# Description: 
# Category: Archival
# Author: Andre Wiethoff
# License: Free for private use (https://www.exactaudiocopy.de/en/index.php/resources/registration/)
# Version: 1.8
# Notes: 

{% set version = '1.8' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'eac-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\exact-audio-copy\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.offline.packages.dotnetfx35

exact-audio-copy-install-offline:
  test.nop:
    - name: Exact Audio Copy must be installed manually due to dotnetfx35 requirement. See the {{ downloads }} folder for the installer.
 
{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
