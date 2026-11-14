# Name: hfs-explorer
# Website: https://www.catacombae.org/hfsexplorer/
# Description: An application for accessing HFS/HFS+/HFSX file systems
# Category: Archival
# Author: Erik Larsson
# License: GNU General Public License v3+ (https://github.com/unsound/hfsexplorer/blob/master/doc/gpl.txt)
# Version: 2026.4.9
# Notes: 

# renovate: datasource=github-releases depName=unsound/hfsexplorer
{% set version = '2026.4.9' %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set PROGRAM_FILES = "%ProgramFiles(x86)%" %}
{% from 'bitcurator/_macros/is_installed.jinja' import check_installed, get_version %}
{% set installed = check_installed('HFSExplorer') | trim == 'true' %}
{% set installed_version = get_version('HFSExplorer') | trim %}
{% set pkg = 'hfs-explorer-' ~ version ~ '-setup.exe' %}
{% set exists = salt['file.file_exists'](downloads + '\\hfs-explorer\\' + pkg) %}
{% if exists %}

{% if installed and installed_version | length > 0 and installed_version != version %}

HFS Explorer {{ installed_version }} is installed - uninstalling offline:
  test.nop

hfs-explorer-uninstall-offline:
  cmd.run:
    - name: '"{{ PROGRAM_FILES }}\HFSExplorer\uninst.exe" /S'

hfs-explorer-install-offline-update:
  cmd.run:
    - name: '"{{ downloads }}\hfs-explorer\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\hfs-explorer\'

{% else %}

hfs-explorer-install-offline:
  cmd.run:
    - name: '"{{ downloads }}\hfs-explorer\{{ pkg }}" /S'
    - shell: cmd
    - cwd: '{{ downloads }}\hfs-explorer\'

{% endif %}
{% else %}
{{ pkg }} does not exist - not installing:
  test.nop
{% endif %}
