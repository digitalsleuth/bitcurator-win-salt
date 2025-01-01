{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set PROGRAM_FILES = salt['environ.get']('PROGRAMFILES') %}
{% set START_MENU = PROGRAMDATA + '\Microsoft\Windows\Start Menu\Programs' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = '3201e8a2e407728111b17a633da9b9a2ce1f7a02bb23a39881b6cb9028674b4e' %}
{% set castver = '0.15.6' %}
{% set wslver = '1.2.5.0' %}

include:
  - bitcurator.wsl.wsl2-update
  - bitcurator.config.user

wsl-config-version:
  cmd.run:
    - name: 'wsl --set-default-version 2'
    - shell: cmd
    - require:
      - sls: bitcurator.wsl.wsl2-update

{% if salt['file.file_exists']('C:\\salt\\tempdownload\\BitCurator-WSL-24.04.tar') and salt['file.check_hash']('C:\\salt\\tempdownload\\BitCurator-WSL-24.04.tar', hash)%}

wsl-template-already-downloaded:
  test.nop

{% else %}

wsl-get-template:
  file.managed:
    - name: 'C:\salt\tempdownload\BitCurator-WSL-24.04.tar'
    - source: https://sourceforge.net/projects/winfor/files/wsl/BitCurator-WSL-24.04.tar/download
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'

{% endif %}

wsl-update-command:
  cmd.run:
    - name: 'wsl --update'
    - shell: cmd
    - require:
      - cmd: wsl-config-version
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'


wsl-make-install-directory:
  file.directory:
    - name: '{{ inpath }}\wsl\'
    - win_inheritance: True
    - makedirs: True
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'

wsl-import-template:
  cmd.run:
    - name: 'wsl --import BitCurator-WSL {{ inpath }}\wsl\ C:\salt\tempdownload\BitCurator-WSL-24.04.tar'
    - shell: cmd
    - require:
      - file: wsl-make-install-directory
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'

wsl-get-cast:
  cmd.run:
    - name: 'wsl -d BitCurator-WSL echo bitcurator | wsl -d BitCurator-WSL sudo -S wget -O /tmp/cast-v{{ castver }}-linux-amd64.deb https://github.com/ekristen/cast/releases/download/v{{ castver }}/cast-v{{ castver }}-linux-amd64.deb'
    - shell: cmd
    - require:
      - cmd: wsl-import-template

wsl-install-cast:
  cmd.run:
    - name: 'wsl -d BitCurator-WSL echo bitcurator | wsl -d BitCurator-WSL sudo -S apt-get install -y /tmp/cast-v{{ castver }}-linux-amd64.deb'
    - shell: cmd
    - require:
      - cmd: wsl-get-cast

wsl-install-bitcurator:
  cmd.run:
    - name: 'wsl -d BitCurator-WSL echo bitcurator | wsl -d BitCurator-WSL sudo -S cast install --mode addon --user bcadmin bitcurator/bitcurator-salt'
    - shell: cmd
    - require:
      - cmd: wsl-install-cast

wsl-shortcut:
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
      - cmd: wsl-config-version
      - file: wsl-make-install-directory
      - cmd: wsl-import-template

wsl-portals-shortcut:
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
      - file: wsl-shortcut
      - cmd: wsl-config-version
      - file: wsl-make-install-directory
      - cmd: wsl-import-template

wsl-delete-template:
  file.absent:
    - name: 'C:\salt'
    - require:
      - cmd: wsl-config-version
      - file: wsl-make-install-directory
      - cmd: wsl-import-template
