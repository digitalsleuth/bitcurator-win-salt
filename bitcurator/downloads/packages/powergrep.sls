# Name: powergrep
# Website: https://www.powergrep.com/
# Description: Graphical GREP tool for Windows
# Category: Archival
# Author: Jan Goyvaerts
# License: Free Trial
# Version: 5.3.6
# Notes: 

{% set version = '5.3.6' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '637be71fe2505e68e2cac0bb0ca01aa7bf6b7b160bce2337c7e56f488196b260' %}

powergrep-download-only:
  file.managed:
    - name: '{{ downloads }}\powergrep\SetupPowerGREPDemo-{{ version }}.exe'
    - source: https://download.jgsoft.com/powergrep/SetupPowerGREPDemo.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
