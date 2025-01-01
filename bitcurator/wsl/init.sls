include:
  - bitcurator.wsl.wsl
 
wsl-states:
  test.nop:
    - require:
      - sls: bitcurator.wsl.wsl
