# Name: vrenamer
# Website: https://vrenamer.com/
# Description: Mass renaming software
# Category: Archival
# Author: Carlos Verdier
# License: GNU General Public License v3 (https://sourceforge.net/projects/vrenamer/)
# Version: 1.6.1
# Notes: 

{% set version = '1.6.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'vRenamer_' ~ (version | replace(".","")) ~ '_setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\vrenamer\\' + pkg) %}

{% if exists %}

vrenamer-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\vrenamer\{{ pkg }}" /SP- /VERYSILENT /NORESTART /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\vrenamer\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
