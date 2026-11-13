# Name: Google Chrome
# Website: https://www.google.com
# Description: Google Web Browser
# Category: Browsers
# Author: Google
# License: https://policies.google.com/terms
# Version: 108.0.5359.72
# Notes: 

{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% set current_user = salt['environ.get']('USERNAME') %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set home = salt['user.info'](user).home %}
{% else %}
{% set home = "C:\\Users\\" + user %}
{% endif %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'GoogleChromeStandaloneEnterprise64.msi' %}
{% set exists = salt['file.file_exists'](downloads + '\\chrome\\' + pkg) %}

{% if exists %}

include:
  - bitcurator.config.user

chrome-install-offline:
  cmd.run:
    - name: 'msiexec /i "{{ downloads }}\chrome\{{ pkg }}" /qn /norestart'
    - shell: cmd
    - cwd: '{{ downloads }}\chrome\'

chrome-del-shortcut-offline:
  file.absent:
    - names:
      - 'C:\Users\Public\Desktop\Google Chrome.lnk'
      - '{{ home }}\Desktop\Google Chrome.lnk'
    {% if user != current_user %}
      - 'C:\Users\{{ current_user }}\Desktop\Google Chrome.lnk'
    {% endif %}
    - require:
      - cmd: chrome-install-offline
      - user: user-{{ user }}

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
