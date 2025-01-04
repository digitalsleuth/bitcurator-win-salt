# Name: openrefine
# Website: https://openrefine.org/
# Description: Open source tool for working with messy data
# Category: Archival
# Author: OpenRefine
# License: BSD 3-Clause (https://github.com/OpenRefine/OpenRefine/blob/master/LICENSE.txt)
# Version: 3.8.7
# Notes: 

{% set version = '3.8.7' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '32b70c90ccf8c19ba08f8fd0484d4f1c6db948f1011aa23e724205dded16526d' %}

openrefine-download-only:
  file.managed:
    - name: '{{ downloads }}\openrefine\openrefine-win-with-java-installer-{{ version }}.exe'
    - source: https://github.com/OpenRefine/OpenRefine/releases/download/{{ version }}/openrefine-win-with-java-installer-{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
