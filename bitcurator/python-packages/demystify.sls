# Name: demystify
# Website: https://github.com/exponential-decay/demystify
# Description: Analysis engine for siegfried and DROID reports
# Category: Archival
# Author: Ross Spencer
# License: Copyright - As Is (https://github.com/exponential-decay/demystify/blob/main/LICENSE.txt)
# Version: 1.0.0
# Notes: demystify, sqlitefid, pathlesstaken

include:
  - bitcurator.packages.python3

demystify-install:
  pip.installed:
    - name: git+https://github.com/exponential-decay/demystify
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - upgrade: True
    - require:
      - sls: bitcurator.packages.python3

demystify-install-requirement:
  pip.installed:
    - name: lxml==4.9.1
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - upgrade: False
    - require:
      - sls: bitcurator.packages.python3
      - pip: demystify-install

sqlitefid-wrapper:
  file.managed:
    - name: 'C:\Program Files\Python310\Scripts\sqlitefid.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'python3 "C:\Program Files\Python310\Lib\site-packages\demystify\sqlitefid\sqlitefid.py" %*'
    - require:
      - pip: demystify-install

pathlesstaken-wrapper:
  file.managed:
    - name: 'C:\Program Files\Python310\Scripts\pathlesstaken.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'python3 "C:\Program Files\Python310\Lib\site-packages\demystify\pathlesstaken\pathlesstaken.py" %*'
    - require:
      - pip: demystify-install

