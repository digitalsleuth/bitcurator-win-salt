# Name: FTK Imager
# Website: https://www.exterro.com
# Description: Forensic Image Acquisition and Triage tool
# Category: Archival
# Author: Exterro Inc / AccessData
# License: EULA
# Version: 4.7.3.81
# Notes:

{% set version = '4.7.3.81' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('ftk-imager') %}

ftk-imager-download-only:
  file.managed:
    - name: '{{ downloads }}\ftk-imager\FTK-Imager-x64-{{ version }}.exe'
    - source: https://d1kpmuwb7gvu1i.cloudfront.net/Imgr/{{ version }}%20Release/Exterro_FTK_Imager_%28x64%29-{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
