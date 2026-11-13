# Name: windirstat
# Website: https://windirstat.net/
# Description: Disk usage statistics viewer for Microsoft Windows
# Category: Archival
# Author: Multiple (https://github.com/windirstat/windirstat/blob/master/CONTRIBUTORS.md)
# License: GNU General Public License v2 (https://github.com/windirstat/windirstat/blob/master/LICENSE.md)
# Version: 2.1.1
# Notes: 

# renovate: datasource=github-releases depName=windirstat/windirstat
{% set version = '2.1.1' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'WinDirStat-x64-' ~ version ~ '.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\windirstat\\' + pkg) %}

{% if exists %}

windirstat-install-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\windirstat\{{ pkg }}" /qn /norestart'
    - shell: cmd
    - cwd: '{{ downloads }}\windirstat\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
