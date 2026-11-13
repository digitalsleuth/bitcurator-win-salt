# Name: beyondcompare
# Website: https://www.scootersoftware.com/
# Description: Software to compare, merge, and synchronize data
# Category: Archival
# Author: Scooter Software (https://www.scootersoftware.com/about)
# License: Free Trial - Additional Licensing (https://www.scootersoftware.com/kb/licensev5)
# Version: 5.0.4
# Notes: 

{% set version = '5.0.4' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set subver = get_hash('beyond-compare', 'subver') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'BCompare-' ~ version ~ '.' ~ subver ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\beyond-compare\\' + pkg) %}

{% if exists %}

beyond-compare-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\beyond-compare\{{ pkg }}" /SP- /ALLUSERS /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\beyond-compare\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
