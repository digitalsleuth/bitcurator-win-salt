# Name: Sublime Text
# Website: https://www.sublimetext.com
# Description: Text Editor for markup and code
# Category: Documents / Editors
# Author: Sublime HQ Pty Ltd
# License: EULA (https://www.sublimehq.com/eula)
# Version: 4189
# Notes: 

{% set version = '4189' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'sublime_text_build_' ~ version ~ '_x64_setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\sublime\\' + pkg) %}

{% if exists %}

sublime-text-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\sublime\{{ pkg }}" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    - shell: cmd
    - cwd: '{{ downloads }}\sublime\'

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
