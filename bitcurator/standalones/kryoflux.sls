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
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('kryoflux') %}

kryoflux-drivers-download:
  file.managed:
    - name: '{{ inpath }}\kryoflux\kryoflux_{{ version }}_windows_r2.zip'
    - source: https://www.kryoflux.com/download/kryoflux_{{ version }}_windows_r2.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
