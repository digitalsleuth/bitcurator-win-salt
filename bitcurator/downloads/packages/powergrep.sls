# Name: powergrep
# Website: https://www.powergrep.com/
# Description: Graphical GREP tool for Windows
# Category: Archival
# Author: Jan Goyvaerts
# License: Free Trial
# Version: 5.4.2
# Notes: 

{% set version = '5.4.2' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set hash = get_hash('powergrep') %}

powergrep-download-only:
  file.managed:
    - name: '{{ downloads }}\powergrep\SetupPowerGREPDemo-{{ version }}.exe'
    - source: https://download.jgsoft.com/powergrep/SetupPowerGREPDemo.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
