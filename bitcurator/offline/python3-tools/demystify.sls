# Name: demystify
# Website: https://github.com/exponential-decay/demystify
# Description: Analysis engine for siegfried and DROID reports
# Category: Archival
# Author: Ross Spencer
# License: Copyright - As Is (https://github.com/exponential-decay/demystify/blob/main/LICENSE.txt)
# Version: 2.0.0
# Notes: demystify, sqlitefid, pathlesstaken

{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set exists = salt['file.directory_exists'](downloads + '\\demystify\\packages') %}

{% if exists %}

include:
  - bitcurator.offline.packages.python3

demystify-install-offline:
  cmd.run:
    - name: '"C:\Program Files\Python311\python.exe" -m pip install --no-index --find-links=.\packages .'
    - cwd: '{{ downloads }}\demystify\'
    - require:
      - sls: bitcurator.offline.packages.python3

sqlitefid-wrapper-offline:
  file.managed:
    - name: 'C:\Program Files\Python311\Scripts\sqlitefid.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'python3 "C:\Program Files\Python311\Lib\site-packages\demystify\sqlitefid\sqlitefid.py" %*'
    - require:
      - cmd: demystify-install-offline

pathlesstaken-wrapper-offline:
  file.managed:
    - name: 'C:\Program Files\Python311\Scripts\pathlesstaken.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'python3 "C:\Program Files\Python311\Lib\site-packages\demystify\pathlesstaken\pathlesstaken.py" %*'
    - require:
      - cmd: demystify-install-offline

{% else %}
{{ downloads }}\demystify\packages does not exist - not installing:
  test.nop
{% endif %}
