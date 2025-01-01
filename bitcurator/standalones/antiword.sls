# Name: antiword
# Website: https://github.com/grobian/antiword - https://cran.r-project.org/web/packages/antiword/index.html
# Description: 
# Category: Archival
# Author: Ardi van Os
# License: GNU General Public License
# Version: 1.3.4
# Notes: 

{% set version = '1.3.4' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = 'c1dfb249ab94492c861659ecc06d0597bb988f55dcac82a6377adff00298e965' %}

antiword-download:
  file.managed:
    - name: 'C:\salt\tempdownload\antiword_{{ version }}.zip'
    - source: 'https://cran.r-project.org/bin/windows/contrib/4.5/antiword_{{ version }}.zip'
    - source_hash: sha256={{ hash }}
    - makedirs: True

antiword-extract:
  archive.extracted:
    - name: '{{ inpath }}\'
    - enforce_toplevel: True
    - source: 'C:\salt\tempdownload\antiword_{{ version }}.zip'
    - overwrite: True
    - require:
      - file: antiword-download

antiword-path:
  win_path.exists:
    - name: '{{ inpath }}\antiword'
    - require:
      - file: antiword-download
