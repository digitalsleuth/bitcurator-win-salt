# Name: jhove
# Website: https://jhove.openpreservation.org/
# Description: JSTOR/Harvard Object Validation Environment - File validation and characterisation
# Category: Archival
# Author: Open Preservation Foundation
# License: GNU Lesser Public License v2.1 (https://github.com/openpreserve/jhove/blob/integration/LICENSE)
# Version: 1.32.0
# Notes: Packaged separately for silent unattended installation

{% set version = '1.32.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = 'ce548598ddd107a349007c5ab0f9e4c1c40ad858cd3095dc592fc9197a3cbbc4' %}

jhove-download-only:
  file.managed:
    - name: '{{ downloads }}\jhove\jove-{{ version }}.zip'
    - source: salt://bitcurator/files/jhove-{{ version }}.zip
    - skip_verify: True
    - makedirs: True
