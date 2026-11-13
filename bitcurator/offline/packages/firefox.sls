# Name: Firefox
# Website: https://www.mozilla.org/en-US/firefox/new/
# Description: Mozilla web browser
# Category: Browsers
# Author: Mozilla Foundation
# License: Mozilla Public License 2.0 (https://www.mozilla.org/en-US/MPL/)
# Version: 133.0.3
# Notes: 

{% set version = '133.0.3' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'Firefox Setup ' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\firefox\\' + pkg) %}
{% from 'bitcurator/_macros/is_installed.jinja' import check_installed %}
{% set installed = check_installed('Mozilla Firefox*') | trim == 'true' %}

{% if not installed %}
{% if exists %}

firefox-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\firefox\{{ pkg }}" /S /DESKTOPSHORTCUT=FALSE'
    - shell: cmd
    - cwd: '{{ downloads }}\firefox\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}

{% else %}
Mozilla Firefox is already installed:
  test.nop
{% endif %}
