# Name: bagger
# Website: https://github.com/LibraryOfCongress/bagger?tab=readme-ov-file
# Description: 
# Category: Archival
# Author: Library of Congress
# License: Multiple (https://github.com/LibraryOfCongress/bagger/blob/master/LICENSE.txt)
# Version: 2.8.1
# Notes: Requires Java - https://javadl.oracle.com/webapps/download/AutoDL?BundleId=251408_0d8f12bc927a4e2c9f8568ca567db4ee

{% set version = '2.8.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('bagger') %}

bagger-download-only:
  file.managed:
    - name: '{{ downloads }}\bagger\bagger-{{ version }}.zip'
    - source: https://github.com/LibraryOfCongress/bagger/releases/download/v{{ version }}/bagger-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
