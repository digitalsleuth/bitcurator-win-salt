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
{% set hash = '913674149e82b56227eaa3b8227bbc1a7067487334280efc802172585427ba27' %}

antiword-download:
  file.managed:
    - name: 'C:\salt\tempdownload\antiword_{{ version }}.zip'
    - source: 'https://cran.r-project.org/bin/windows/contrib/4.4/antiword_{{ version }}.zip'
    - skip_verify: True
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
