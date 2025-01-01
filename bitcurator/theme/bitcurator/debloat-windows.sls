# The debloat scripts in use are originally sourced from
# https://github.com/Jawabiscuit/Win10-Initial-Setup-Script 
# and have been modified for use in this toolset 
# Modifications can be found in this repo and at
# https://github.com/digitalsleuth/Win10-Initial-Setup-Script

{% set PS_PATHS = salt['environ.get']('PSMODULEPATH') %}
{% set FIRST_PATH = PS_PATHS.split(";")[0] %}
{% for PS_PATH in PS_PATHS.split(";") %}

transfer-debloat-script-{{ PS_PATH }}:
  file.managed:
    - name: '{{ PS_PATH }}\Win10Debloat\Win10.ps1'
    - source: salt://bitcurator/config/Win10.ps1
    - makedirs: True
    - win_inheritance: True

transfer-debloat-module-{{ PS_PATH }}:
  file.managed:
    - name: '{{ PS_PATH }}\Win10Debloat\Win10.psm1'
    - source: salt://bitcurator/config/Win10.psm1
    - makedirs: True
    - win_inheritance: True

transfer-debloat-preset-{{ PS_PATH }}:
  file.managed:
    - name: '{{ PS_PATH }}\Win10Debloat\debloat.preset'
    - source: salt://bitcurator/config/debloat.preset
    - makedirs: True
    - win_inheritance: True

{% endfor %}

debloat-windows:
  cmd.run:
    - name: 'powershell -nop -ep Bypass -File "Win10.ps1" -include "Win10.psm1" -preset "debloat.preset"'
    - cwd: '{{ FIRST_PATH }}\Win10Debloat\'
    - shell: powershell
