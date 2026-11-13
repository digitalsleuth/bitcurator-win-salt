# Name: gimp
# Website: https://www.gimp.org/downloads/
# Description: GNU Image Manipulation Program
# Category: Archival
# Author: Multiple (https://www.gimp.org/docs/userfaq.html#is-there-a-company-or-a-foundation-behind-gimp)
# License: GNU General Public License v3+ (https://www.gimp.org/docs/userfaq.html#whats-the-gimps-license-and-how-do-i-comply-with-it)
# Version: 2.10.38
# Notes: 

{% set version = '2.10.38' %}
{% set major_version = '2.10' %}
{% from 'bitcurator/_macros/hashes.jinja' import get_hash %}
{% set minor_version = get_hash('gimp', 'minor_version') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'gimp-' ~ version ~ '-setup' ~ minor_version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\gimp\\' + pkg) %}

{% if exists %}

gimp-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\gimp\{{ pkg }}" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - cwd: '{{ downloads }}\gimp\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
