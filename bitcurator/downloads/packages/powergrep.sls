# Name: powergrep
# Website: https://www.powergrep.com/
# Description: Graphical GREP tool for Windows
# Category: Archival
# Author: Jan Goyvaerts
# License: Free Trial
# Version: 5.3.7
# Notes: 

{% set version = '5.3.7' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '3f3a9c461a791aaa1536b1a4f3d9539a0885bd2d731073c4de783b1461c43ea1' %}

powergrep-download-only:
  file.managed:
    - name: '{{ downloads }}\powergrep\SetupPowerGREPDemo-{{ version }}.exe'
    - source: https://download.jgsoft.com/powergrep/SetupPowerGREPDemo.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
