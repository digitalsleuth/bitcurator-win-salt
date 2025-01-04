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
{% set hash = 'c1dfb249ab94492c861659ecc06d0597bb988f55dcac82a6377adff00298e965' %}

antiword-download-only:
  file.managed:
    - name: '{{ downloads }}\antiword\antiword_{{ version }}.zip'
    - source: 'https://cran.r-project.org/bin/windows/contrib/4.5/antiword_{{ version }}.zip'
    - source_hash: sha256={{ hash }}
    - makedirs: True
