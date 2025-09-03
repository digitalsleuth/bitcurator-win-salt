# Name: Bulk Rename Utility
# Website: https://www.bulkrenameutility.co.uk
# Description: Tool to rename multiple files with similar names
# Category: Archival
# Author: TGRMN Software
# License: EULA (https://www.bulkrenameutility.co.uk/License.php)
# Version: 4.1.0.0
# Notes:

{% set version = '4.1.0.0' %}
{% set hash = '043d511228707ccb864b62eac1df59a8d6cde5c0876494c2cc8d0dc73e86f8ac' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

bulk-rename-utility-download-only:
  file.managed:
    - name: '{{ downloads }}\bulk-rename-utility\BRU_setup_{{ version }}.exe'
    - source: https://www.bulkrenameutility.co.uk/Downloads/BRU_setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
