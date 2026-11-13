# Name: ExifTool
# Website: https://exiftool.org
# Description: Tool for analysing EXIF data from files
# Category: Documents / Editors
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Version: 13.63
# Notes:

{% set version_query = salt['http.query']('https://exiftool.org/ver.txt', backend='requests', verify_ssl=True) %}
{% set version = version_query.get('body').strip() %}
{% set hash_query = salt['http.query']('https://exiftool.org/checksums.txt', backend='requests', verify_ssl=True) %}
{% set hash_content = hash_query.get('body').splitlines() %}
{% set ns = namespace(exiftool_hash='') %}
{% for line in hash_content %}
{% if 'SHA2-256(exiftool-' ~ version ~ '_64.zip)' in line %}
{% set ns.exiftool_hash = line.split()[-1].strip() %}
{% endif %}
{% endfor %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

exiftool-download-only:
  file.managed:
    - name: '{{ downloads }}\exiftool\exiftool-{{ version }}.zip'
{#  - source: https://exiftool.org/exiftool-{{ version }}_64.zip #}
    - source: https://sourceforge.net/projects/exiftool/files/exiftool-{{ version }}_64.zip/download
    - source_hash: sha256={{ ns.exiftool_hash }}
    - makedirs: True
