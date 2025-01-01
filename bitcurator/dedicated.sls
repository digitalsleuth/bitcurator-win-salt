include:
  - bitcurator.config
  - bitcurator.theme.computer-name
  - bitcurator.theme.bitcurator.debloat-windows
  - bitcurator.addon
  - bitcurator.theme.bitcurator
 
dedicated-states:
  test.nop:
    - require:
      - sls: bitcurator.config
      - sls: bitcurator.theme.computer-name
      - sls: bitcurator.theme.bitcurator.debloat-windows
      - sls: bitcurator.addon
      - sls: bitcurator.theme.bitcurator
