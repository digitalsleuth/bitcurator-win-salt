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
{% set hash = 'fec4f190e09b58845927c185472af16d6a2e76f26c203110cb562b9be54d29e0' %}

antiword-download:
  file.managed:
    - name: 'C:\salt\tempdownload\antiword_{{ version }}.zip'
    - source: 'https://cran.r-project.org/bin/windows/contrib/4.4/antiword_{{ version }}.zip'
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
