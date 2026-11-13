# Name: Java Runtime Environment
# Website: https://www.java.com
# Description: Java Engine
# Category: Requirements
# Author: Oracle
# License: https://www.oracle.com/legal/terms.html
# Version: 8.0.4310.10
# Notes:

{% set version = '8.0.4310.10' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set file_ver = get_hash('jre8', 'file_ver') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set hash = get_hash('jre8') %}

jre8-download-only:
  file.managed:
    - name: '{{ downloads }}\jre8\jre-{{ file_ver }}-windows-x64.exe'
    - source: https://github.com/digitalsleuth/salt-winrepo-ng/raw/refs/heads/main/files/jre-{{ file_ver }}-windows-x64.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
