# Name: Bulk Rename Utility
# Website: https://www.bulkrenameutility.co.uk
# Description: Tool to rename multiple files with similar names
# Category: Archival
# Author: TGRMN Software
# License: EULA (https://www.bulkrenameutility.co.uk/License.php)
# Version: 4.0.1.0
# Notes:

{% set version = '4.0.1.0' %}
{% set hash = 'dc0a5315412816af7016e51e4f5db582c8cf94816b05ad67b56c418b3f740279' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

bulk-rename-utility-download-only:
  file.managed:
    - name: '{{ downloads }}\bulk-rename-utility\BRU_setup_{{ version }}.exe'
    - source: https://www.bulkrenameutility.co.uk/Downloads/BRU_setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
