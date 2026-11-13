# Name: WSL Setup
# Website: https://microsoft.com
# Description: Windows Subsystem for Linux setup
# Category: Terminals
# Author: Microsoft
# License: EULA
# Version: 0.0
# Notes: 

{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% set SID = salt['user.info'](user).uid %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('offline', 'C:\\bitcurator-downloads') %}
{% set saltpath = salt['pillar.get']('saltpath', 'C:\Program Files\Salt Project\Salt\salt-call.exe') %}
{% set version = salt['cp.get_file_str']("C:\ProgramData\Salt Project\Salt\srv\salt\\bitcurator\VERSION") %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set defender_status = salt['cmd.run']('powershell -c "(Get-Service windefend).Status"') %}

include:
  - bitcurator.config.user

wsl-defender-exclusion-offline:
  cmd.run:
{% if defender_status == "Running" %}
    - names:
      - 'echo "Defender is {{ defender_status }}"'
      - 'Add-MpPreference -ExclusionPath "{{ inpath }}"'
      - 'Add-MpPreference -ExclusionPath "{{ downloads }}"'
      - 'Add-MpPreference -ExclusionPath "{{ PROGRAMDATA }}\Salt Project\Salt\var"'
{% else %}
    - name:
      - 'echo "Defender is {{ defender_status }}"'
{% endif %}
    - shell: powershell

wsl-cleanup-offline:
  cmd.run:
    - name: 'dism.exe /online /cleanup-image /revertpendingactions'
    - shell: cmd

wsl-install-offline:
  dism.feature_installed:
    - name: Microsoft-Windows-Subsystem-Linux
    - restart: False
    - enable_parent: True
    - unless:
      - fun: cmd.run
        cmd: 'dism /online /get-featureinfo /featurename:Microsoft-Windows-Subsystem-Linux | findstr "Enabled"'
        shell: cmd
        python_shell: True

vmp-install-offline:
  dism.feature_installed:
    - name: VirtualMachinePlatform
    - restart: False
    - enable_parent: True
    - unless:
      - fun: cmd.run
        cmd: 'dism /online /get-featureinfo /featurename:VirtualMachinePlatform | findstr "Enabled"'
        shell: cmd
        python_shell: True

powershell-execution-policy-offline:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
    - vname: ExecutionPolicy
    - vtype: REG_SZ
    - vdata: Bypass

powershell-execution-policy-path-offline:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
    - vname: Path
    - vtype: REG_SZ
    - vdata: 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'

wsl-set-uac-1-offline:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
    - vname: ConsentPromptBehaviorAdmin
    - vtype: REG_DWORD
    - vdata: 0

wsl-set-uac-2-offline:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
    - vname: PromptOnSecureDesktop
    - vtype: REG_DWORD
    - vdata: 0

wsl-powershell-stager-offline:
  file.managed:
    - name: '{{ inpath }}\wsl\wsl-after-reboot.ps1'
    - source: salt://bitcurator/offline/wsl/wsl.ps1
    - win_inheritance: True
    - makedirs: True
    - require:
      - reg: powershell-execution-policy-offline
      - reg: powershell-execution-policy-path-offline
      - reg: wsl-set-uac-1-offline
      - reg: wsl-set-uac-2-offline

wsl-config-stager-offline:
  file.managed:
    - name: '{{ inpath }}\wsl\wsl-config.cmd'
    - source: salt://bitcurator/offline/wsl/wsl-config.cmd
    - win_inheritance: True
    - makedirs: True
    - require:
      - reg: powershell-execution-policy-offline
      - reg: powershell-execution-policy-path-offline
      - reg: wsl-set-uac-1-offline
      - reg: wsl-set-uac-2-offline
      - file: wsl-powershell-stager-offline

wsl-powershell-stager-customize-offline:
  file.replace:
    - name: '{{ inpath }}\wsl\wsl-after-reboot.ps1'
    - pattern: _this_user_
    - repl: {{ user }}
    - count: 1
    - require:
      - file: wsl-powershell-stager-offline
      - user: user-{{ user }}

wsl-config-stager-customize-cmd-offline:
  file.replace:
    - name: '{{ inpath }}\wsl\wsl-config.cmd'
    - pattern: _this_path_
    - repl: {{ inpath | regex_escape }}
    - count: 1
    - require:
      - file: wsl-config-stager-offline

wsl-config-stager-customize-offline-offline:
  file.replace:
    - name: '{{ inpath }}\wsl\wsl-after-reboot.ps1'
    - pattern: _this_offline_
    - repl: {{ downloads | regex_escape }}
    - count: 1
    - require:
      - file: wsl-powershell-stager-offline
      - file: wsl-powershell-stager-customize-offline
      - user: user-{{ user }}

wsl-config-stager-customize-salt-exe-offline:
  file.replace:
    - name: '{{ inpath }}\wsl\wsl-after-reboot.ps1'
    - pattern: _salt_exe_
    - repl: {{ saltpath | regex_escape }}
    - count: 1
    - require:
      - file: wsl-powershell-stager-offline
      - file: wsl-powershell-stager-customize-offline
      - user: user-{{ user }}

wsl-config-stager-customize-path-offline:
  file.replace:
    - name: '{{ inpath }}\wsl\wsl-after-reboot.ps1'
    - pattern: _this_path_
    - repl: {{ inpath | regex_escape }}
    - count: 1
    - require:
      - file: wsl-powershell-stager-offline
      - file: wsl-powershell-stager-customize-offline
      - user: user-{{ user }}

wsl-config-run-on-reboot-offline:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce
    - vname: "BitCurator WSL Offline Config"
    - vtype: REG_SZ
    - vdata: 'C:\Windows\system32\cmd.exe /q /c {{ inpath }}\wsl\wsl-config.cmd'
    - require:
      - dism: wsl-install-offline
      - dism: vmp-install-offline
      - file: wsl-config-stager-offline
      - file: wsl-powershell-stager-offline
      - file: wsl-powershell-stager-customize-offline
      - file: wsl-config-stager-customize-path-offline
      - file: wsl-config-stager-customize-cmd-offline
      - file: wsl-config-stager-customize-offline-offline
      - file: wsl-config-stager-customize-salt-exe-offline

wsl-log-append-offline:
  file.append:
    - name: 'C:\bitcurator-saltstack-{{ version|trim }}-wsl.log'
    - text: 'GOING FOR REBOOT NOW'

system-restart-offline:
  system.reboot:
    - timeout: 0
    - in_seconds: True
    - only_on_pending_reboot: True
    - require:
      - dism: wsl-install-offline
      - dism: vmp-install-offline
      - file: wsl-config-stager-offline
      - file: wsl-powershell-stager-offline
      - file: wsl-powershell-stager-customize-offline
      - file: wsl-config-stager-customize-path-offline
      - file: wsl-config-stager-customize-cmd-offline
      - file: wsl-config-stager-customize-offline-offline
      - file: wsl-config-stager-customize-salt-exe-offline
      - reg: wsl-config-run-on-reboot-offline
