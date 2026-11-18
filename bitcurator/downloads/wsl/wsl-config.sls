{% set wsl_choice = salt['pillar.get']('wsl_choice', 'bitcurator24') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set PROGRAM_FILES = salt['environ.get']('PROGRAMFILES') %}
{% set START_MENU = PROGRAMDATA ~ '\\Microsoft\\Windows\\Start Menu' %}
{% set START_PROGRAMS = START_MENU ~ '\\Programs' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set castver = '1.0.42' %}
{% set user_pass = "bcadmin:bcadmin" %}
{% from 'bitcurator/_macros/wsl_functions.jinja' import wsl_install, wsl_apt_update, wsl_bootstrap_user, wsl_diskpart_compact %}
{% if wsl_choice == 'bitcurator24' %}
  {% set distro = 'BitCurator-24' %}
  {% set ubuntu = 'Ubuntu-24.04' %}
{% elif wsl_choice == 'bitcurator26' %}
  {% set distro = 'BitCurator-26' %}
  {% set ubuntu = 'Ubuntu-26.04' %}
{% endif %}
{% set folder = wsl_choice %}
{% set wsl_cmd = 'wsl -d ' ~ distro %}
{% set shortcut_name = folder|upper ~ '.lnk' %}

{{ wsl_install(
    'wsl-make-install-directory-download-only',
    'wsl-install-distro-download-only',
    inpath ~ '\\wsl\\' ~ folder,
    'wsl --install '~ ubuntu ~' --name ' ~ distro ~ ' --location ' ~ inpath ~ '\\wsl\\' ~ folder ~ ' -n',
    inpath ~ '\\wsl\\' ~ folder ~ '\\ext4.vhdx'
) }}

{{ wsl_apt_update('wsl-apt-update-upgrade-download-only', wsl_cmd, 'wsl-install-distro-download-only') }}

{{ wsl_bootstrap_user(
    'wsl-bootstrap-user-bcadmin-download-only',
    wsl_cmd, 'wsl-install-distro-download-only', 'wsl-apt-update-upgrade-download-only', user_pass
) }}

wsl-download-cast-download-only:
  cmd.run:
    - name: '{{ wsl_cmd }} wget -O /cast-v{{ castver }}.deb https://github.com/ekristen/cast/releases/download/v{{ castver }}/cast-v{{ castver }}-linux-amd64.deb'
    - shell: cmd
    - unless: '{{ wsl_cmd }} command -v cast'
    - require:
      - cmd: wsl-install-distro-download-only
      - cmd: wsl-bootstrap-user-bcadmin-download-only

wsl-install-cast-download-only:
  cmd.run:
    - name: '{{ wsl_cmd }} dpkg -i /cast-v{{ castver }}.deb'
    - shell: cmd
    - unless: '{{ wsl_cmd }} command -v cast'
    - require:
      - cmd: wsl-download-cast-download-only

wsl-remove-cast-binary-download-only:
  cmd.run:
    - name: '{{ wsl_cmd }} rm /cast-v{{ castver }}.deb'
    - shell: cmd
    - onlyif: '{{ wsl_cmd }} test -f /cast-v{{ castver }}.deb'
    - require:
      - cmd: wsl-install-cast-download-only

wsl-cast-install-bitcurator-download-only:
  cmd.run:
    - name: '{{ wsl_cmd }} bash -c "cast install --mode addon --user bcadmin bitcurator/bitcurator-salt || true"'
    - shell: cmd
    - creates: '\\\\wsl.localhost\\{{ distro }}\\home\\bcadmin\\bitcurator-saltstack.log'
    - require:
      - cmd: wsl-remove-cast-binary-download-only

wsl-copy-cast-bitcurator-results-download-only:
  cmd.run:
    - name: '{{ wsl_cmd }} cp /var/cache/cast/installer/logs/saltstack.log /home/bcadmin/bitcurator-saltstack.log'
    - shell: cmd
    - creates: '\\\\wsl.localhost\\{{ distro }}\\home\\bcadmin\\bitcurator-saltstack.log'
    - require:
      - cmd: wsl-cast-install-bitcurator-download-only
    - onlyif:
      - fun: file.file_exists
        path: '\\\\wsl.localhost\\{{ distro }}\\var\\cache\\cast\\installer\\logs\\saltstack.log'

wsl-setup-mounts-and-cleanup-download-only:
  cmd.run:
    - name: |
        {{ wsl_cmd }} bash -c "mkdir -p /mnt/{aff,bde,e01,ewf,ewf_mount,iscsi,shadow_mount,usb,vss,windows_mount} && mkdir -p /mnt/windows_mount{1..5} /mnt/shadow_mount/vss{1..30} && rm -rf /var/cache/salt/* /srv/* /root/.cache/* /var/cache/cast/*"
    - shell: cmd
    - require:
      - cmd: wsl-install-distro-download-only

wsl-set-default-user-download-only:
  cmd.run:
    - name: 'wsl --manage {{ distro }} --set-default-user bcadmin'
    - shell: cmd
    - require:
      - cmd: wsl-bootstrap-user-bcadmin-download-only

wsl-shutdown-download-only:
  cmd.run:
    - name: 'wsl --shutdown'
    - shell: cmd
    - require:
      - cmd: wsl-set-default-user-download-only
      - cmd: wsl-setup-mounts-and-cleanup-download-only

{{ wsl_diskpart_compact(
    'wsl-create-diskpart-script-download-only', 'wsl-diskpart-compact-download-only',
    inpath ~ '\\wsl\\' ~ folder ~ '\\ext4.vhdx', inpath ~ '\\wsl\\' ~ folder ~ '\\diskpart-compact.txt',
    'wsl-shutdown-download-only'
) }}


wsl-sync-download-only:
  test.nop:
    - require:
      - cmd: wsl-diskpart-compact-download-only

wsl-copy-{{ folder }}-download-only:
  cmd.run:
    - name: 'robocopy "{{ inpath }}\wsl\{{ folder }}" "{{ downloads }}\wsl\{{ folder }}" /E /R:1 /W:1 /XF diskpart-compact.txt'
    - shell: cmd
    - success_retcodes:
      - 1
      - 2
      - 3
      - 4
      - 5
      - 6
      - 7
    - require:
      - test: wsl-sync-download-only

wsl-unregister-{{ folder }}-download-only:
  cmd.run:
    - name: powershell -nop -ep Bypass -c "if ((Get-Item '{{ downloads }}\wsl\{{ folder }}\ext4.vhdx').Length -ne (Get-Item '{{ inpath }}\wsl\{{ folder }}\ext4.vhdx').Length) { Write-Error 'The copied disk does not match the installed disk - not unregistering'; exit 1 }; wsl --unregister {{ distro }}; exit $LASTEXITCODE"
    - shell: cmd
    - require:
      - cmd: wsl-copy-{{ folder }}-download-only
