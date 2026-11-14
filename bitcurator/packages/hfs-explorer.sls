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
{% set PROGRAM_FILES = "%ProgramFiles(x86)%" %}
{% from 'bitcurator/_macros/is_installed.jinja' import check_installed, get_version %}
{% set installed = check_installed('HFSExplorer') | trim == 'true' %}
{% set installed_version = get_version('HFSExplorer') | trim %}
{% if installed and installed_version | length > 0 and installed_version != version %}

include:
  - bitcurator.repos

HFS Explorer {{ installed_version }} is installed - uninstalling:
  test.nop

hfs-explorer-uninstall-to-update:
  cmd.run:
    - name: '"{{ PROGRAM_FILES }}\HFSExplorer\uninst.exe" /S'
    - shell: cmd
    - cwd: "{{ PROGRAM_FILES }}\HFSExplorer"

hfs-explorer-update:
  pkg.installed:
    - require:
      - cmd: hfs-explorer-uninstall

{% else %}

hfs-explorer:
  pkg.installed


{% endif %}
