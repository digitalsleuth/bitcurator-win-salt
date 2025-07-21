include:
  - bitcurator.packages.python3

python3-wheel:
  pip.installed:
    - name: wheel
    - upgrade: True
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: bitcurator.packages.python3

python3-setuptools:
  pip.installed:
    - name: setuptools
    - upgrade: True
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: bitcurator.packages.python3
