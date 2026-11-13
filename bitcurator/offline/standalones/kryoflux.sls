# Name: KryoFlux
# Website: https://kryoflux.com/?page=download
# Description: USB Floppy Controller and drivers
# Category: Archival
# Author: KryoFlyx
# License: Proprietary - Software Preservation Society (packaged with drivers)
# Version: 3.50
# Notes: Drivers only

{% set version = '3.50' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'kryoflux_' ~ version ~ '_windows_r2.zip' %}
{% set exists = salt['file.file_exists'](downloads + '\\kryoflux\\' + pkg) %}

{% if exists %}

kryoflux-drivers-offline:
  file.managed:
    - name: '{{ inpath }}\kryoflux\kryoflux_{{ version }}_windows_r2.zip'
    - source: '{{ downloads }}\kryoflux\{{ pkg }}'
    - skip_verify: True
    - makedirs: True

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
