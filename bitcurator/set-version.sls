set-version:
  file.managed:
    - name: 'C:\\bitcurator-version'
    - source: salt://bitcurator/VERSION
    - replace: True
