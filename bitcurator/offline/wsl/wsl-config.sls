{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set PROGRAM_FILES = salt['environ.get']('PROGRAMFILES') %}
{% set START_MENU = PROGRAMDATA + '\Microsoft\Windows\Start Menu\Programs' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set wslver = '1.2.5.0' %}
{% set pkg = 'ext4.vhdx' %}
{% set exists = salt['file.file_exists'](downloads + '\\wsl\\' + pkg) %}

include:
  - bitcurator.offline.wsl.wsl2-update
  - bitcurator.config.user

wsl-config-version-offline:
  cmd.run:
    - name: 'wsl --set-default-version 2'
    - shell: cmd
    - require:
      - sls: bitcurator.offline.wsl.wsl2-update

{% if exists %}

wsl-make-install-directory-offline:
  file.directory:
    - name: '{{ inpath }}\wsl\'
    - win_inheritance: True
    - makedirs: True

wsl-copy-vhdx-offline:
  file.copy:
    - name: '{{ inpath }}\wsl\ext4.vhdx'
    - source: '{{ downloads }}\wsl\{{ pkg }}'
    - makedirs: True
    - require:
      - file: wsl-make-install-directory-offline
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'

wsl-import-offline:
  cmd.run:
    - name: 'wsl --import-in-place BitCurator-WSL {{ inpath }}\wsl\ext4.vhdx'
    - shell: cmd
    - require:
      - cmd: wsl-config-version-offline
      - file: wsl-copy-vhdx-offline
    - unless:
      - fun: cmd.run
        cmd: 'wsl -l -q | findstr BitCurator-WSL'
        shell: cmd
        python_shell: True

wsl-shortcut-offline:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Windows Subsystem for Linux.lnk'
    - target: '{{ PROGRAM_FILES }}\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForLinux_{{ wslver }}_x64__8wekyb3d8bbwe\wsl.exe'
    - force: True
    - working_dir: '{{ PROGRAM_FILES }}\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForLinux_{{ wslver }}_x64__8wekyb3d8bbwe\'
    - icon_location: '{{ PROGRAM_FILES }}\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForLinux_{{ wslver }}_x64__8wekyb3d8bbwe\wsl.exe'
    - arguments: '~'
    - makedirs: True
    - onlyif:
      - fun: file.directory_exists
        path: '{{ PROGRAM_FILES }}\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForLinux_{{ wslver }}_x64__8wekyb3d8bbwe\'
    - require:
      - cmd: wsl-config-version-offline
      - file: wsl-make-install-directory-offline
      - cmd: wsl-import-offline

wsl-portals-shortcut-offline:
  file.copy:
    - name: '{{ inpath }}\Portals\Terminals\'
    - source: '{{ START_MENU }}\Windows Subsystem for Linux.lnk'
    - preserve: True
    - subdir: True
    - makedirs: True
    - onlyif:
      - fun: file.directory_exists
        path: '{{ PROGRAM_FILES }}\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForLinux_{{ wslver }}_x64__8wekyb3d8bbwe\'
    - require:
      - file: wsl-shortcut-offline
      - cmd: wsl-config-version-offline
      - file: wsl-make-install-directory-offline
      - cmd: wsl-import-offline

{% else %}
{{ pkg }} does not exist - not importing:
  test.nop
{% endif %}
