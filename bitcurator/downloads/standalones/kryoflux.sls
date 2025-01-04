# Name: KryoFlux
# Website: https://kryoflux.com/?page=download
# Description: USB Floppy Controller and drivers
# Category: Archival
# Author: KryoFlyx
# License: Proprietary - Software Preservation Society (packaged with drivers)
# Version: 3.50
# Notes: Drivers only

{% set version = '3.50' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'ae92e569f74846d7be6f83e90ccbfdcb4ad7bc4b942a6a8ca9f905cfcb5c09a5' %}

kryoflux-drivers-download-only:
  file.managed:
    - name: '{{ downloads }}\kryoflux\kryoflux_{{ version }}_windows_r2.zip'
    - source: https://www.kryoflux.com/download/kryoflux_{{ version }}_windows_r2.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
