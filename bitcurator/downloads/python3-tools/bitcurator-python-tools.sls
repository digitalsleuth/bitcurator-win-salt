# Name: bitcurator-python-tools
# Website: https://github.com/bitcurator/bitcurator-python-tools
# Description: BitCurator Python 3 scripts as an installable pip package
# Category: Archival
# Author: Corey Forman (digitalsleuth), Kam Woods, Simson L. Garfinkel
# License: MIT License (https://github.com/BitCurator/bitcurator-python-tools/blob/main/licenses/LICENSE.MIT.md)
# Version: 1.0.0
# Notes:

{% set version = '1.0.0' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}

include:
  - bitcurator.packages.git
  - bitcurator.standalones.portable-python3

bitcurator-python-tools-clone-download-only:
  git.latest:
    - name: https://github.com/bitcurator/bitcurator-python-tools.git
    - target: '{{ downloads }}\bitcurator-python-tools'
    - force_clone: True
    - force_reset: True
    - require:
      - sls: bitcurator.packages.git

bitcurator-python-tools-python-download-only:
  cmd.run:
    - name: '{{ inpath }}\portable-python3\python.exe -m pip download -d packages . setuptools wheel'
    - cwd: '{{ downloads }}\bitcurator-python-tools'
    - require:
      - git: bitcurator-python-tools-clone-download-only
      - sls: bitcurator.standalones.portable-python3
