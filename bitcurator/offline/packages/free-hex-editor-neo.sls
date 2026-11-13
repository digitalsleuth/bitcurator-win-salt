# Name: Hex Editor Neo (Free)
# Website: https://www.hhdsoftware.com
# Description: Hex Editor
# Category: Raw Parsers / Decoders
# Author: HHD Software
# License: EULA (https://www.hhdsoftware.com/company/terms-of-use)
# Version: 8.26.00.9614
# Notes: 

{% set version = '8.26.00.9614' %}
{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% set current_user = salt['environ.get']('USERNAME') %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set home = salt['user.info'](user).home %}
{% else %}
{% set home = "C:\\Users\\" + user %}
{% endif %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'free-hex-editor-neo-' ~ version ~ '.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\free-hex-editor-neo\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.user

free-hex-editor-neo-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\free-hex-editor-neo\{{ pkg }}" -silent -machine'
    - shell: cmd
    - cwd: '{{ downloads }}\free-hex-editor-neo\'

free-hex-editor-icon-offline:
  file.absent:
    - names:
      - '{{ home }}\Desktop\Hex Editor Neo.lnk'
      - 'C:\Users\Public\Desktop\Hex Editor Neo.lnk'
    {% if user != current_user %}
      - 'C:\Users\{{ current_user }}\Desktop\Hex Editor Neo.lnk'
    {% endif %}
    - require:
      - user: user-{{ user }}
      - cmd: free-hex-editor-neo-install-offline
    - watch:
      - cmd: free-hex-editor-neo-install-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
