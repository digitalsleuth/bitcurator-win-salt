include:
  - bitcurator.config.user
  - bitcurator.repos
  - bitcurator.python-packages
  - bitcurator.packages
  - bitcurator.installers
  - bitcurator.standalones
  - bitcurator.cleanup

addon-version-file:
  file.managed:
    - name: 'C:\bitcurator-version'
    - source: salt://bitcurator/VERSION
    - replace: True
    - require:
      - sls: bitcurator.config.user
      - sls: bitcurator.repos
      - sls: bitcurator.python-packages
      - sls: bitcurator.packages
      - sls: bitcurator.installers
      - sls: bitcurator.standalones
      - sls: bitcurator.cleanup
