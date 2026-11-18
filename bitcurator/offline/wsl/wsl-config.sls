{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set PROGRAM_FILES = salt['environ.get']('PROGRAMFILES') %}
{% set START_MENU = PROGRAMDATA + '\Microsoft\Windows\Start Menu' %}
{% set START_PROGRAMS = START_MENU + '\Programs' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set distros = {'bitcurator24': 'BitCurator-24', 'bitcurator26': 'BitCurator-26'} %}


include:
  - bitcurator.config.shims

{% for choice, distro in distros.items() %}

wsl-move-{{ choice }}-offline:
  file.rename:
    - name: '{{ inpath }}\wsl\{{ choice }}'
    - source: '{{ downloads }}\wsl\{{ choice }}\'
    - force: True
    - makedirs: True
    - onlyif:
      - fun: file.directory_exists
        path: '{{ downloads }}\wsl\{{ choice }}'

wsl-import-{{ choice }}-offline:
  cmd.run:
    - name: 'wsl --import-in-place {{ distro }} {{ inpath }}\wsl\{{ choice }}\ext4.vhdx'
    - shell: cmd
    - onlyif:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\{{ choice }}\ext4.vhdx'

wsl-shim-{{ choice }}:
  cmd.run:
    - name: |
        powershell -nop -ep Bypass -c "$wslPath = (Get-Item '{{ PROGRAM_FILES }}\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForLinux_*_x64__8wekyb3d8bbwe\wsl.exe' -ErrorAction SilentlyContinue).FullName; if ($wslPath) { & '{{ inpath }}\New-Shim.ps1' -SourceExe $wslPath -OutPath '{{ inpath }}\shims\wsl.exe' }"
    - shell: cmd
    - onlyif:
      - powershell -nop -ep Bypass -c "if (Test-Path '{{ PROGRAM_FILES }}\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForLinux_*_x64__8wekyb3d8bbwe') { exit 0 } else { exit 1 }"
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\shims\wsl.exe'
    - require:
      - sls: bitcurator.config.shims
      - file: wsl-move-{{ choice }}-offline
      - cmd: wsl-import-{{ choice }}-offline

wsl-shortcut-{{ choice }}:
  file.shortcut:
    - name: '{{ START_PROGRAMS }}\{{ distro }}.lnk'
    - target: '{{ inpath }}\shims\wsl.exe'
    - force: True
    - working_dir: '{{ inpath }}\shims'
    - icon_location: '{{ inpath }}\wsl\{{ choice }}\shortcut.ico'
    - arguments: '-d {{ distro }} ~'
    - makedirs: True
    - require:
      - cmd: wsl-shim-{{ choice }}
    - onlyif:
      - fun: file.directory_exists
        path: '{{ inpath }}\wsl\{{ choice }}'

wsl-portals-shortcut-{{ choice }}:
  file.copy:
    - name: '{{ inpath }}\Portals\Terminals\{{ distro }}.lnk'
    - source: '{{ START_PROGRAMS }}\{{ distro }}.lnk'
    - force: True
    - makedirs: True
    - require:
      - file: wsl-shortcut-{{ choice }}
    - onlyif:
      - fun: file.file_exists
        path: '{{ START_PROGRAMS }}\{{ distro }}.lnk'
      - fun: file.directory_exists
        path: '{{ inpath }}\Portals'

{% endfor %}
