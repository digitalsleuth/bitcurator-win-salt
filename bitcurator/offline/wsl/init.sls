include:
  - bitcurator.offline.wsl.wsl

wsl-states-offline:
  test.nop:
    - require:
      - sls: bitcurator.offline.wsl.wsl
