include:
  - bitcurator.config.user
  - bitcurator.config.del-edge-shortcut
  - bitcurator.config.admin-cmd-prompt
  - bitcurator.config.copy-as-path

config-states:
  test.nop:
    - require:
      - sls: bitcurator.config.user
      - sls: bitcurator.config.del-edge-shortcut
      - sls: bitcurator.config.admin-cmd-prompt
      - sls: bitcurator.config.copy-as-path
