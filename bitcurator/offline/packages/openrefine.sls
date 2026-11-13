# Name: openrefine
# Website: https://openrefine.org/
# Description: Open source tool for working with messy data
# Category: Archival
# Author: OpenRefine
# License: BSD 3-Clause (https://github.com/OpenRefine/OpenRefine/blob/master/LICENSE.txt)
# Version: 3.8.7
# Notes: 

# renovate: datasource=github-releases depName=OpenRefine/OpenRefine
{% set version = '3.8.7' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'openrefine-win-with-java-installer-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\openrefine\\' + pkg) %}

{% if exists %}

openrefine-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\openrefine\{{ pkg }}" /VERYSILENT /ALLUSERS /SUPPRESSMSGBOXES /NORESTART /SP- /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\openrefine\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
