include:
  - bitcurator.installers.hxd
  - bitcurator.installers.windows-terminal
  - bitcurator.installers.windows-winget

bitcurator-installers:
  test.nop:
    - name: bitcurator-installers
    - require:
      - sls: bitcurator.installers.hxd
      - sls: bitcurator.installers.windows-terminal
      - sls: bitcurator.installers.windows-winget

