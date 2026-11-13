# Name: demystify
# Website: https://github.com/exponential-decay/demystify
# Description: Analysis engine for siegfried and DROID reports
# Category: Archival
# Author: Ross Spencer
# License: Copyright - As Is (https://github.com/exponential-decay/demystify/blob/main/LICENSE.txt)
# Version: 2.0.0
# Notes: demystify, sqlitefid, pathlesstaken

include:
  - bitcurator.packages.python3

demystify-install:
  pip.installed:
    - name: git+https://github.com/exponential-decay/demystify
    - bin_env: 'C:\Program Files\Python311\python.exe'
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3

sqlitefid-wrapper:
  file.managed:
    - name: 'C:\Program Files\Python311\Scripts\sqlitefid.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'python3 "C:\Program Files\Python311\Lib\site-packages\demystify\sqlitefid\sqlitefid.py" %*'
    - require:
      - pip: demystify-install

pathlesstaken-wrapper:
  file.managed:
    - name: 'C:\Program Files\Python311\Scripts\pathlesstaken.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'python3 "C:\Program Files\Python311\Lib\site-packages\demystify\pathlesstaken\pathlesstaken.py" %*'
    - require:
      - pip: demystify-install

