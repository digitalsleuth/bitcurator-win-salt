# Name: Bulk Rename Utility
# Website: https://www.bulkrenameutility.co.uk
# Description: Tool to rename multiple files with similar names
# Category: Archival
# Author: TGRMN Software
# License: EULA (https://www.bulkrenameutility.co.uk/License.php)
# Version: 4.0.0.6
# Notes:

{% set version = '4.0.0.6' %}
{% set hash = '9520a6cffbf3e9de104ec12bc2be2c30f50e9194b45aa450176862a833764f38' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

bulk-rename-utility-download-only:
  file.managed:
    - name: '{{ downloads }}\bulk-rename-utility\BRU_setup_{{ version }}.exe'
    - source: https://www.bulkrenameutility.co.uk/Downloads/BRU_setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
