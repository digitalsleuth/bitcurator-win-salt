# Name: demystify
# Website: https://github.com/exponential-decay/demystify
# Description: Analysis engine for siegfried and DROID reports
# Category: Archival
# Author: Ross Spencer
# License: Copyright - As Is (https://github.com/exponential-decay/demystify/blob/main/LICENSE.txt)
# Version: 2.0.0
# Notes: demystify, sqlitefid, pathlesstaken

{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.packages.git
  - bitcurator.standalones.portable-python3

demystify-clone-download-only:
  git.latest:
    - name: https://github.com/exponential-decay/demystify.git
    - target: '{{ downloads }}\demystify'
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git

demystify-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages . setuptools wheel'
    - cwd: '{{ downloads }}\demystify'
    - require:
      - git: demystify-clone-download-only
      - sls: bitcurator.standalones.portable-python3
