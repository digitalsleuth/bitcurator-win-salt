# Name: Bulk Rename Utility
# Website: https://www.bulkrenameutility.co.uk
# Description: Tool to rename multiple files with similar names
# Category: Archival
# Author: TGRMN Software
# License: EULA (https://www.bulkrenameutility.co.uk/License.php)
# Version: 4.0.0.5
# Notes:

{% set version = '4.0.0.5' %}
{% set hash = 'ce80f35d20b658cf6b4ae83fb17b3834c7c9d3797d274c4ff6ced84660ad0706' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

bulk-rename-utility-download-only:
  file.managed:
    - name: '{{ downloads }}\bulk-rename-utility\BRU_setup_{{ version }}.exe'
    - source: https://www.bulkrenameutility.co.uk/Downloads/BRU_setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
