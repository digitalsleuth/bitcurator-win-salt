# Name: antiword
# Website: https://github.com/grobian/antiword - https://cran.r-project.org/web/packages/antiword/index.html
# Description: 
# Category: Archival
# Author: Ardi van Os
# License: GNU General Public License
# Version: 1.3.4
# Notes: 

{% set version = '1.3.4' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '13aa386e19589bf8b572c4b736f5329d780ce08e7c1994d29e0d9f9c557c020a' %}

antiword-download-only:
  file.managed:
    - name: '{{ downloads }}\antiword\antiword_{{ version }}.zip'
    - source: 'https://cran.r-project.org/bin/windows/contrib/4.5/antiword_{{ version }}.zip'
    - source_hash: sha256={{ hash }}
    - makedirs: True
