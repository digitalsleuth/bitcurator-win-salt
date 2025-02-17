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
{% set hash = '913674149e82b56227eaa3b8227bbc1a7067487334280efc802172585427ba27' %}

antiword-download-only:
  file.managed:
    - name: '{{ downloads }}\antiword\antiword_{{ version }}.zip'
    - source: 'https://cran.r-project.org/bin/windows/contrib/4.4/antiword_{{ version }}.zip'
    - skip_verify: True
    - makedirs: True
