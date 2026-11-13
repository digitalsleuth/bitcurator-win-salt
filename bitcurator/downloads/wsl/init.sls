include:
  - bitcurator.downloads.wsl.wsl

wsl-states-download-only:
  test.nop:
    - require:
      - sls: bitcurator.downloads.wsl.wsl
