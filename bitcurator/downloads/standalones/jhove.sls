# Name: jhove
# Website: https://jhove.openpreservation.org/
# Description: JSTOR/Harvard Object Validation Environment - File validation and characterisation
# Category: Archival
# Author: Open Preservation Foundation
# License: GNU Lesser Public License v2.1 (https://github.com/openpreserve/jhove/blob/integration/LICENSE)
# Version: 1.32.0
# Notes: Packaged separately for silent unattended installation

{% set version = '1.32.0' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('jhove') %}

jhove-download-only:
  file.managed:
    - name: '{{ downloads }}\jhove\jhove-{{ version }}.zip'
    - source: salt://bitcurator/files/jhove-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
