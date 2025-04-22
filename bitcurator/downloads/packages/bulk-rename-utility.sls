# Name: Bulk Rename Utility
# Website: https://www.bulkrenameutility.co.uk
# Description: Tool to rename multiple files with similar names
# Category: Archival
# Author: TGRMN Software
# License: EULA (https://www.bulkrenameutility.co.uk/License.php)
# Version: 4.0.0.7
# Notes:

{% set version = '4.0.0.7' %}
{% set hash = 'c70d2e20e777c1d215fc6a80f27f43da6eff26da4383425b1e65e209e0b99a31' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}

bulk-rename-utility-download-only:
  file.managed:
    - name: '{{ downloads }}\bulk-rename-utility\BRU_setup_{{ version }}.exe'
    - source: https://www.bulkrenameutility.co.uk/Downloads/BRU_setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
