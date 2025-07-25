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
{% set version = salt['cp.get_file_str']("C:\ProgramData\Salt Project\Salt\srv\salt\bitcurator\VERSION") %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set defender_status = salt['cmd.run']('powershell -c "(Get-Service windefend).Status"') %}

include:
  - bitcurator.config.user

wsl-defender-exclusion:
  cmd.run:
{% if defender_status == "Running" %}
    - names:
      - 'echo "Defender is {{ defender_status }}"'
      - 'Add-MpPreference -ExclusionPath "{{ inpath }}"'
      - 'Add-MpPreference -ExclusionPath "C:\salt\tempdownload"'
      - 'Add-MpPreference -ExclusionPath "{{ PROGRAMDATA }}\Salt Project\Salt\var"'
{% else %}
    - name:
      - 'echo "Defender is {{ defender_status }}"'
{% endif %}
    - shell: powershell

wsl-cleanup:
  cmd.run:
    - name: 'dism.exe /online /cleanup-image /revertpendingactions'
    - shell: cmd

wsl-install:
  dism.feature_installed:
    - name: Microsoft-Windows-Subsystem-Linux
    - restart: False
    - enable_parent: True
    - unless:
      - fun: cmd.run
        cmd: 'dism /online /get-featureinfo /featurename:Microsoft-Windows-Subsystem-Linux | findstr "Enabled"'
        shell: cmd
        python_shell: True

vmp-install:
  dism.feature_installed:
    - name: VirtualMachinePlatform
    - restart: False
    - enable_parent: True
    - unless:
      - fun: cmd.run
        cmd: 'dism /online /get-featureinfo /featurename:VirtualMachinePlatform | findstr "Enabled"'
        shell: cmd
        python_shell: True

powershell-execution-policy:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
    - vname: ExecutionPolicy
    - vtype: REG_SZ
    - vdata: Bypass

powershell-execution-policy-path:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
    - vname: Path
    - vtype: REG_SZ
    - vdata: 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'

wsl-set-uac-1:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
    - vname: ConsentPromptBehaviorAdmin
    - vtype: REG_DWORD
    - vdata: 0

wsl-set-uac-2:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
    - vname: PromptOnSecureDesktop
    - vtype: REG_DWORD
    - vdata: 0

wsl-powershell-stager:
  file.managed:
    - name: 'C:\salt\tempdownload\wsl-after-reboot.ps1'
    - source: salt://bitcurator/wsl/wsl.ps1
    - win_inheritance: True
    - makedirs: True
    - require:
      - reg: powershell-execution-policy
      - reg: powershell-execution-policy-path
      - reg: wsl-set-uac-1
      - reg: wsl-set-uac-2

wsl-config-stager:
  file.managed:
    - name: 'C:\salt\tempdownload\wsl-config.cmd'
    - source: salt://bitcurator/wsl/wsl-config.cmd
    - win_inheritance: True
    - makedirs: True
    - require:
      - reg: powershell-execution-policy
      - reg: powershell-execution-policy-path
      - reg: wsl-set-uac-1
      - reg: wsl-set-uac-2
      - file: wsl-powershell-stager

wsl-powershell-stager-customize:
  file.replace:
    - name: 'C:\salt\tempdownload\wsl-after-reboot.ps1'
    - pattern: _this_user_
    - repl: {{ user }}
    - count: 1
    - require:
      - file: wsl-powershell-stager
      - user: user-{{ user }}

wsl-config-stager-customize-path:
  file.replace:
    - name: 'C:\salt\tempdownload\wsl-after-reboot.ps1'
    - pattern: _this_path_
    - repl: {{ inpath | regex_escape }}
    - count: 1
    - require:
      - file: wsl-powershell-stager
      - file: wsl-powershell-stager-customize
      - user: user-{{ user }}

wsl-config-run-on-reboot:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce
    - vname: "BitCurator WSL Config"
    - vtype: REG_SZ
    - vdata: 'C:\Windows\system32\cmd.exe /q /c C:\salt\tempdownload\wsl-config.cmd'
    - require:
      - dism: wsl-install
      - dism: vmp-install
      - file: wsl-config-stager
      - file: wsl-powershell-stager
      - file: wsl-powershell-stager-customize
      - file: wsl-config-stager-customize-path

wsl-log-append:
  file.append:
    - name: 'C:\bitcurator-saltstack-{{ version|trim }}-wsl.log'
    - text: 'GOING FOR REBOOT NOW'

system-restart:
  system.reboot:
    - timeout: 0
    - in_seconds: True
    - only_on_pending_reboot: True
    - require:
      - dism: wsl-install
      - dism: vmp-install
      - file: wsl-config-stager
      - file: wsl-powershell-stager
      - file: wsl-powershell-stager-customize
      - file: wsl-config-stager-customize-path
      - reg: wsl-config-run-on-reboot
