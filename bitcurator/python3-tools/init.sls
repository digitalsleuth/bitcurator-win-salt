include:
  - bitcurator.python3-tools.bagit-python
  - bitcurator.python3-tools.brunnhilde
  - bitcurator.python3-tools.demystify
  - bitcurator.python3-tools.dfxml-python
  - bitcurator.python3-tools.dvd-transcoder
  - bitcurator.python3-tools.fido
  - bitcurator.python3-tools.mailbagit
  - bitcurator.python3-tools.openai-whisper
  - bitcurator.python3-tools.pymupdf

bitcurator-python3-tools:
  test.nop:
    - name: bitcurator-python3-tools
    - require:
      - sls: bitcurator.python3-tools.bagit-python
      - sls: bitcurator.python3-tools.brunnhilde
      - sls: bitcurator.python3-tools.demystify
      - sls: bitcurator.python3-tools.dfxml-python
      - sls: bitcurator.python3-tools.dvd-transcoder
      - sls: bitcurator.python3-tools.fido
      - sls: bitcurator.python3-tools.mailbagit
      - sls: bitcurator.python3-tools.openai-whisper
      - sls: bitcurator.python3-tools.pymupdf

