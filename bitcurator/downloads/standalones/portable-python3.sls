# Name: Python 3 Embeddable
# Website: https://www.python.org
# Description: Python Programming Language Framework
# Category: Requirements
# Author: Python Software Foundation
# License: Python Software Foundation License Version 2.0 (https://docs.python.org/3.11/license.html)
# Version: 3.11.9
# Notes: Portable Python3 with pip via get-pip.py

{% set version = '3.11.9' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('portable-python3') %}

portable-python3-download-only:
  file.managed:
    - name: '{{ downloads }}\python3\python-{{ version }}-embed-amd64.zip'
    - source: https://www.python.org/ftp/python/{{ version }}/python-{{ version }}-embed-amd64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

portable-python3-extract-download-only:
  archive.extracted:
    - name: '{{ downloads }}\portable-python3'
    - source: '{{ downloads }}\python3\python-{{ version }}-embed-amd64.zip'
    - enforce_toplevel: False
    - require:
      - file: portable-python3-download-only

portable-python3-edit-pth-download-only:
  file.replace:
    - name: '{{ downloads }}\portable-python3\python3{{ version.split(".")[1] }}._pth'
    - pattern: '#import site'
    - repl: 'import site'
    - prepend_if_not_found: False
    - count: 1
    - backup: false
    - require:
      - archive: portable-python3-extract-download-only

get-pip-download-only:
  file.managed:
    - name: '{{ downloads }}\portable-python3\get-pip.py'
    - source: https://bootstrap.pypa.io/get-pip.py
    - skip_verify: True
    - makedirs: True
    - require:
      - file: portable-python3-edit-pth-download-only

get-pip-run-download-only:
  cmd.run:
    - name: '"{{ downloads }}\portable-python3\python.exe" get-pip.py'
    - cwd: '{{ downloads }}\portable-python3'
    - require:
      - file: get-pip-download-only
