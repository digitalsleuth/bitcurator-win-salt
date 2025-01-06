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
{% set hash = 'fec4f190e09b58845927c185472af16d6a2e76f26c203110cb562b9be54d29e0' %}

antiword-download-only:
  file.managed:
    - name: '{{ downloads }}\antiword\antiword_{{ version }}.zip'
    - source: 'https://cran.r-project.org/bin/windows/contrib/4.4/antiword_{{ version }}.zip'
    - source_hash: sha256={{ hash }}
    - makedirs: True
