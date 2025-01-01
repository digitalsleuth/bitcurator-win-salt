include:
  - bitcurator.python-packages.bagit-python
  - bitcurator.python-packages.brunnhilde
  - bitcurator.python-packages.demystify
  - bitcurator.python-packages.dfxml-python
  - bitcurator.python-packages.dvd-transcoder
  - bitcurator.python-packages.fido
  - bitcurator.python-packages.mailbagit
  - bitcurator.python-packages.openai-whisper
  - bitcurator.python-packages.pymupdf

bitcurator-python-packages:
  test.nop:
    - name: bitcurator-python-packages
    - require:
      - sls: bitcurator.python-packages.bagit-python
      - sls: bitcurator.python-packages.brunnhilde
      - sls: bitcurator.python-packages.demystify
      - sls: bitcurator.python-packages.dfxml-python
      - sls: bitcurator.python-packages.dvd-transcoder
      - sls: bitcurator.python-packages.fido
      - sls: bitcurator.python-packages.mailbagit
      - sls: bitcurator.python-packages.openai-whisper
      - sls: bitcurator.python-packages.pymupdf

