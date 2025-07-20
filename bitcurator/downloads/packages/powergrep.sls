# Name: powergrep
# Website: https://www.powergrep.com/
# Description: Graphical GREP tool for Windows
# Category: Archival
# Author: Jan Goyvaerts
# License: Free Trial
# Version: 5.3.8
# Notes: 

{% set version = '5.3.8' %}
{% set downloads = salt['pillar.get']('downloads', 'C:\bc-downloads') %}
{% set hash = '2735c106c0c1412499a873d7f535f062be2805ff8bb558f238d12018c569a96a' %}

powergrep-download-only:
  file.managed:
    - name: '{{ downloads }}\powergrep\SetupPowerGREPDemo-{{ version }}.exe'
    - source: https://download.jgsoft.com/powergrep/SetupPowerGREPDemo.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
