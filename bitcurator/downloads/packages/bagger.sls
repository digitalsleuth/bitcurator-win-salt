# Name: bagger
# Website: https://github.com/LibraryOfCongress/bagger?tab=readme-ov-file
# Description: 
# Category: Archival
# Author: Library of Congress
# License: Multiple (https://github.com/LibraryOfCongress/bagger/blob/master/LICENSE.txt)
# Version: 2.8.1
# Notes: Requires Java - https://javadl.oracle.com/webapps/download/AutoDL?BundleId=251408_0d8f12bc927a4e2c9f8568ca567db4ee

{% set version = '2.8.1' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '8a1991e39764e007a336a5585e7c2c79a8edf406a63ef81d587b3c70b421af23' %}

bagger-download-only:
  file.managed:
    - name: '{{ downloads }}\bagger\bagger-{{ version }}.zip'
    - source: https://github.com/LibraryOfCongress/bagger/releases/download/v{{ version }}/bagger-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True
