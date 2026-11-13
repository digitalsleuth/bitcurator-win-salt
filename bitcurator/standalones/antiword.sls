# Name: antiword
# Website: https://github.com/grobian/antiword - https://cran.r-project.org/web/packages/antiword/index.html
# Description: 
# Category: Archival
# Author: Ardi van Os
# License: GNU General Public License
# Version: 1.3.5
# Notes: 

{% set version = '1.3.5' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('antiword') %}

include:
  - bitcurator.config.shims

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

antiword-shim:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File {{ inpath }}\New-Shim.ps1 -SourceExe {{ inpath }}\antiword\bin\antiword.exe -OutPath {{ inpath }}\shims\antiword.exe'
    - require:
      - archive: antiword-extract
      - sls: bitcurator.config.shims
