# Name: antiword
# Website: https://github.com/grobian/antiword - https://cran.r-project.org/web/packages/antiword/index.html
# Description: 
# Category: Archival
# Author: Ardi van Os
# License: GNU General Public License
# Version: 1.3.5
# Notes: 

{% set version = '1.3.5' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('antiword') %}

antiword-download-only:
  file.managed:
    - name: '{{ downloads }}\antiword\antiword_{{ version }}.zip'
    - source: 'https://cran.r-project.org/bin/windows/contrib/4.4/antiword_{{ version }}.zip'
    - source_hash: sha256={{ hash }}
    - makedirs: True
