# Name: Microsoft PowerToys
# Website: https://github.com/microsoft/powertoys
# Description: Windows productivity system utilities
# Category: Utilities
# Author: Microsoft
# License: MIT (https://github.com/microsoft/PowerToys/blob/main/LICENSE)
# Version: 0.86.0
# Notes:

# renovate: datasource=github-releases depName=microsoft/PowerToys
{% set version = '0.86.0' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'PowerToysSetup-' ~ version ~ '-x64.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\powertoys\\' + pkg) %}

{% if exists %}

ms-powertoys-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\powertoys\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\powertoys\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
