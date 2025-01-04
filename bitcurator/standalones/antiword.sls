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
{% set hash = '13aa386e19589bf8b572c4b736f5329d780ce08e7c1994d29e0d9f9c557c020a' %}

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
