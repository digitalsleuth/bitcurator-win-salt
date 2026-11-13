# Name: VLC Media Player
# Website: https://www.videolan.org/
# Description: Media Player
# Category: Utilities
# Author: VideoLAN
# License: GNU General Public License v2 (https://www.videolan.org/legal.html)
# Version: 3.0.21
# Notes: 

{% set version = '3.0.21' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set pkg = 'vlc-' ~ version ~ '-win64.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\vlc\\' + pkg) %}

{% if exists %}

vlc-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\vlc\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\vlc\'

vlc-del-shortcut-offline:
  file.absent:
    - names:
      - 'C:\Users\Public\Desktop\VLC media player.lnk'
    - require:
      - cmd: vlc-install-offline

{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
