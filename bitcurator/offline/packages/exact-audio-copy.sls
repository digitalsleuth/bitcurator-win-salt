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
  cmd.run:
    - name: '"{{ downloads }}\exact-audio-copy\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\exact-audio-copy\'
    - require:
      - sls: bitcurator.offline.packages.dotnetfx35

exact-audio-copy-del-shortcut-offline:
  file.absent:
    - name: 'C:\Users\Public\Desktop\Exact Audio Copy.lnk'
    - require:
      - cmd: exact-audio-copy-install-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
