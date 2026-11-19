# Name: demystify
# Website: https://github.com/exponential-decay/demystify
# Description: Analysis engine for siegfried and DROID reports
# Category: Archival
# Author: Ross Spencer
# License: Copyright - As Is (https://github.com/exponential-decay/demystify/blob/main/LICENSE.txt)
# Version: 2.0.0
# Notes: demystify, sqlitefid, pathlesstaken

{% set version = '2.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.standalones.portable-python3
  - bitcurator.downloads.packages.python3

demystify-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download --only-binary=:all: -d "{{ downloads }}\demystify\packages" demystify-digipres=={{ version }}'
    - require:
      - sls: bitcurator.standalones.portable-python3
      - sls: bitcurator.downloads.packages.python3
