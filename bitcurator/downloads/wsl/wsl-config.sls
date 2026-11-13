{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set PROGRAM_FILES = salt['environ.get']('PROGRAMFILES') %}
{% set START_MENU = PROGRAMDATA + '\Microsoft\Windows\Start Menu\Programs' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set hash = '3201e8a2e407728111b17a633da9b9a2ce1f7a02bb23a39881b6cb9028674b4e' %}
{% set gui_hash = 'b6dccc93561456c87a6de4cf635bc6c28db50171b09b13e93ede5541e235cddf' %}
{% set castver = '0.15.6' %}
{% set wslver = '1.2.5.0' %}
{% set gui = false %}

include:
  - bitcurator.wsl.wsl2-update
  - bitcurator.config.user

wsl-config-version-download-only:
  cmd.run:
    - name: 'wsl --set-default-version 2'
    - shell: cmd
    - require:
      - sls: bitcurator.wsl.wsl2-update

{% if salt['file.file_exists']('C:\\salt\\tempdownload\\BitCurator-WSL-24.04.tar') and salt['file.check_hash']('C:\\salt\\tempdownload\\BitCurator-WSL-24.04.tar', hash)%}

wsl-template-already-downloaded-download-only:
  test.nop

{% else %}

wsl-get-template-download-only:
  file.managed:
    - name: 'C:\salt\tempdownload\BitCurator-WSL-24.04.tar'
    - source: https://sourceforge.net/projects/winfor/files/wsl/BitCurator-WSL-24.04.tar/download
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'

{% endif %}

wsl-update-command-download-only:
  cmd.run:
    - name: 'wsl --update'
    - shell: cmd
    - require:
      - cmd: wsl-config-version-download-only
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'


wsl-make-install-directory-download-only:
  file.directory:
    - name: '{{ inpath }}\wsl\'
    - win_inheritance: True
    - makedirs: True
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'

wsl-import-template-download-only:
  cmd.run:
    - name: 'wsl --import BitCurator-WSL {{ inpath }}\wsl\ C:\salt\tempdownload\BitCurator-WSL-24.04.tar'
    - shell: cmd
    - require:
      - file: wsl-make-install-directory-download-only
    - unless:
      - fun: file.file_exists
        path: '{{ inpath }}\wsl\ext4.vhdx'

wsl-get-cast-download-only:
  cmd.run:
    - name: 'wsl -d BitCurator-WSL echo bitcurator | wsl -d BitCurator-WSL sudo -S wget -O /tmp/cast-v{{ castver }}-linux-amd64.deb https://github.com/ekristen/cast/releases/download/v{{ castver }}/cast-v{{ castver }}-linux-amd64.deb'
    - shell: cmd
    - require:
      - cmd: wsl-import-template-download-only

wsl-install-cast-download-only:
  cmd.run:
    - name: 'wsl -d BitCurator-WSL echo bitcurator | wsl -d BitCurator-WSL sudo -S apt-get install -y /tmp/cast-v{{ castver }}-linux-amd64.deb'
    - shell: cmd
    - require:
      - cmd: wsl-get-cast-download-only

wsl-install-bitcurator-download-only:
  cmd.run:
    - name: 'wsl -d BitCurator-WSL echo bitcurator | wsl -d BitCurator-WSL sudo -S cast install --mode addon --user bcadmin bitcurator/bitcurator-salt'
    - shell: cmd
    - require:
      - cmd: wsl-install-cast-download-only

wsl-shortcut-download-only:
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
      - cmd: wsl-config-version-download-only
      - file: wsl-make-install-directory-download-only
      - cmd: wsl-import-template-download-only

wsl-portals-shortcut-download-only:
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
      - file: wsl-shortcut-download-only
      - cmd: wsl-config-version-download-only
      - file: wsl-make-install-directory-download-only
      - cmd: wsl-import-template-download-only

wsl-shutdown-download-only:
  cmd.run:
    - name: 'wsl --shutdown'
    - shell: cmd
    - require:
      - cmd: wsl-install-bitcurator-download-only

wsl-stage-vhdx-download-only:
  file.copy:
    - name: '{{ downloads }}\wsl\ext4.vhdx'
    - source: '{{ inpath }}\wsl\ext4.vhdx'
    - force: True
    - makedirs: True
    - require:
      - cmd: wsl-shutdown-download-only

wsl-delete-template-download-only:
  file.absent:
    - name: 'C:\salt'
    - require:
      - file: wsl-stage-vhdx-download-only
      - cmd: wsl-config-version-download-only
      - file: wsl-make-install-directory-download-only
      - cmd: wsl-import-template-download-only
