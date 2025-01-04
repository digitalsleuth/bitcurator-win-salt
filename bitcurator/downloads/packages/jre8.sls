# Name: Java Runtime Environment
# Website: https://www.java.com
# Description: Java Engine
# Category: Requirements
# Author: Oracle
# License: https://www.oracle.com/legal/terms.html
# Version: 8.0.4310.10
# Notes:

{% set version = '8.0.4310.10' %}
{% set file_ver = '8u431' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '6e6e541bc5b96ef69ebaf247d8cf9bfb0eb8b6fee289a9f163db74b08983ceec' %}

jre8-download-only:
  file.managed:
    - name: '{{ downloads }}\jre8\jre-{{ file_ver }}-windows-x64.exe'
    - source: https://github.com/digitalsleuth/salt-winrepo-ng/raw/refs/heads/main/files/jre-{{ file_ver }}-windows-x64.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
