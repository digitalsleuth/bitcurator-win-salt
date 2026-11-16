{% set wsl_choice = salt['pillar.get']('wsl_choice', 'bitcurator24') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set PROGRAM_FILES = salt['environ.get']('PROGRAMFILES') %}
{% set START_MENU = PROGRAMDATA ~ '\\Microsoft\\Windows\\Start Menu' %}
{% set START_PROGRAMS = START_MENU ~ '\\Programs' %}
{% set APPDATA = salt['environ.get']('APPDATA') %}
{% set inpath = salt['pillar.get']('inpath', 'C:\\standalone') %}
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
{% set shortcut_name = distro ~ '.lnk' %}

{{ wsl_install(
    'wsl-make-install-directory',
    'wsl-install-distro',
    inpath ~ '\\wsl\\' ~ folder,
    'wsl --install '~ ubuntu ~ ' --name ' ~ distro ~ ' --location ' ~ inpath ~ '\\wsl\\' ~ folder ~ ' -n',
    inpath ~ '\\wsl\\' ~ folder ~ '\\ext4.vhdx'
) }}

{{ wsl_apt_update('wsl-apt-update-upgrade', wsl_cmd, 'wsl-install-distro') }}

{{ wsl_bootstrap_user(
    'wsl-bootstrap-user-bcadmin',
    wsl_cmd, 'wsl-install-distro', 'wsl-apt-update-upgrade', user_pass
) }}

wsl-download-cast:
  cmd.run:
    - name: '{{ wsl_cmd }} wget -O /cast-v{{ castver }}.deb https://github.com/ekristen/cast/releases/download/v{{ castver }}/cast-v{{ castver }}-linux-amd64.deb'
    - shell: cmd
    - unless: '{{ wsl_cmd }} command -v cast'
    - require:
      - cmd: wsl-install-distro
      - cmd: wsl-bootstrap-user-bcadmin

wsl-install-cast:
  cmd.run:
    - name: '{{ wsl_cmd }} dpkg -i /cast-v{{ castver }}.deb'
    - shell: cmd
    - unless: '{{ wsl_cmd }} command -v cast'
    - require:
      - cmd: wsl-download-cast

wsl-remove-cast-binary:
  cmd.run:
    - name: '{{ wsl_cmd }} rm /cast-v{{ castver }}.deb'
    - shell: cmd
    - onlyif: '{{ wsl_cmd }} test -f /cast-v{{ castver }}.deb'
    - require:
      - cmd: wsl-install-cast

wsl-cast-install-bitcurator:
  cmd.run:
    - name: '{{ wsl_cmd }} bash -c "cast install --mode addon --user bcadmin bitcurator/bitcurator-salt || true"'
    - shell: cmd
    - creates: '\\\\wsl.localhost\\{{ distro }}\\home\\bcadmin\\bitcurator-saltstack.log'
    - require:
      - cmd: wsl-remove-cast-binary

wsl-copy-cast-bitcurator-results:
  cmd.run:
    - name: '{{ wsl_cmd }} cp /var/cache/cast/installer/logs/saltstack.log /home/bcadmin/bitcurator-saltstack.log'
    - shell: cmd
    - creates: '\\\\wsl.localhost\\{{ distro }}\\home\\bcadmin\\bitcurator-saltstack.log'
    - require:
      - cmd: wsl-cast-install-bitcurator
    - onlyif:
      - fun: file.file_exists
        path: '\\\\wsl.localhost\\{{ distro }}\\var\\cache\\cast\\installer\\logs\\saltstack.log'

wsl-setup-mounts-and-cleanup:
  cmd.run:
    - name: |
        {{ wsl_cmd }} bash -c "mkdir -p /mnt/{aff,bde,e01,ewf,ewf_mount,iscsi,shadow_mount,usb,vss,windows_mount} && mkdir -p /mnt/windows_mount{1..5} /mnt/shadow_mount/vss{1..30} && rm -rf /var/cache/salt/* /srv/* /root/.cache/* /var/cache/cast/*"
    - shell: cmd
    - require:
      - cmd: wsl-install-distro

wsl-set-default-user:
  cmd.run:
    - name: 'wsl --manage {{ distro }} --set-default-user bcadmin'
    - shell: cmd
    - require:
      - cmd: wsl-bootstrap-user-bcadmin

wsl-shutdown:
  cmd.run:
    - name: 'wsl --shutdown'
    - shell: cmd
    - require:
      - cmd: wsl-set-default-user
      - cmd: wsl-setup-mounts-and-cleanup

{{ wsl_diskpart_compact(
    'wsl-create-diskpart-script', 'wsl-diskpart-compact',
    inpath ~ '\\wsl\\' ~ folder ~ '\\ext4.vhdx', inpath ~ '\\wsl\\' ~ folder ~ '\\diskpart-compact.txt',
    'wsl-shutdown'
) }}


wsl-shortcut-{{ distro }}:
  file.copy:
    - name: '{{ START_PROGRAMS }}\{{ shortcut_name }}'
    - source: '{{ APPDATA }}\Microsoft\Windows\Start Menu\{{ shortcut_name }}'
    - force: True
    - onlyif:
      - fun: file.file_exists
        path: '{{ APPDATA }}\Microsoft\Windows\Start Menu\{{ shortcut_name }}'

wsl-portals-shortcut-{{ distro }}:
  file.copy:
    - name: '{{ inpath }}\Portals\Terminals\{{ shortcut_name }}'
    - source: '{{ START_PROGRAMS }}\{{ shortcut_name }}'
    - force: True
    - onlyif:
      - fun: file.file_exists
        path: '{{ START_PROGRAMS }}\{{ shortcut_name }}'
      - fun: file.directory_exists
        path: '{{ inpath }}\Portals'

wsl-bitcurator-sync:
  test.nop:
    - require:
      - file: wsl-portals-shortcut-{{ distro }}
      - cmd: wsl-diskpart-compact
      - file: wsl-shortcut-{{ distro }}
