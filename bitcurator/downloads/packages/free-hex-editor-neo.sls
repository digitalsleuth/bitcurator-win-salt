# Name: Hex Editor Neo (Free)
# Website: https://www.hhdsoftware.com
# Description: Hex Editor
# Category: Raw Parsers / Decoders
# Author: HHD Software
# License: EULA (https://www.hhdsoftware.com/company/terms-of-use)
# Version: 8.26.00.9614
# Notes: 

{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set version = '8.26.00.9614' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('free-hex-editor-neo') %}

free-hex-editor-neo-download-only:
  file.managed:
    - name: '{{ downloads }}\free-hex-editor-neo\free-hex-editor-neo-{{ version }}.exe'
    - source: https://www.hhdsoftware.com/download/free-hex-editor-neo.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
