# Name: WSL Setup
# Website: https://microsoft.com
# Description: Windows Subsystem for Linux setup
# Category: Terminals
# Author: Microsoft
# License: EULA
# Version: 0.0
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set downloads = salt['pillar.get']('downloads', 'C:\\bitcurator-downloads') %}
{% set wsl_choice = salt['pillar.get']('wsl_choice', 'bitcurator24') %}
{% if wsl_choice == 'bitcurator24' %}
  {% set wsl_text = 'BitCurator-24' %}
{% elif wsl_choice == 'bitcurator26' %}
  {% set wsl_text = 'BitCurator-26' %}
{% endif %}
{% set user = salt['environ.get']('USERNAME') %}
{% set home = "C:\\Users\\" + user %}
{% set version = salt['cp.get_file_str']("C:\\ProgramData\\Salt Project\\Salt\\srv\\salt\\bitcurator\\VERSION") %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set defender_status = salt['cmd.powershell']('((Get-Service) -match "WinDefend").Name') %}

{% if defender_status.lower() == "windefend" %}
wsl-defender-exclusion-download-only:
  cmd.run:
    - names:
      - 'echo "Defender is present on this system."'
      - 'Add-MpPreference -ExclusionPath "{{ inpath }}"'
      - 'Add-MpPreference -ExclusionPath "{{ downloads }}"'
      - 'Add-MpPreference -ExclusionPath "{{ PROGRAMDATA }}\Salt Project\Salt\var"'
    - shell: powershell

{% else %}

"Defender is not present on this system - no exclusions are required to install WSL for BitCurator.":
  test.nop

{% endif %}

wsl-install-download-only:
  cmd.run:
    - name: 'wsl --install --no-distribution'
    - shell: cmd
    - success_retcodes: 3010

wsl-default-version-download-only:
  cmd.run:
    - name: 'wsl --set-default-version 2'
    - shell: cmd
    - require:
      - cmd: wsl-install-download-only

wsl-shutdown-after-install-download-only:
  cmd.run:
    - name: 'wsl --shutdown'
    - shell: cmd
    - require:
      - cmd: wsl-install-download-only
      - cmd: wsl-default-version-download-only

wsl-update-wslconfig-download-only:
  ini.options_present:
    - name: '{{ home }}\.wslconfig'
    - separator: '='
    - no_spaces: True
    - sections:
        wsl2:
          networkingMode: mirrored
          dnsTunneling: 'true'
          firewall: 'true'
    - require:
      - cmd: wsl-default-version-download-only
      - cmd: wsl-install-download-only
      - cmd: wsl-shutdown-after-install-download-only

powershell-execution-policy-download-only:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
    - vname: ExecutionPolicy
    - vtype: REG_SZ
    - vdata: Bypass

powershell-execution-policy-path-download-only:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
    - vname: Path
    - vtype: REG_SZ
    - vdata: 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'

wsl-set-uac-1-download-only:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
    - vname: ConsentPromptBehaviorAdmin
    - vtype: REG_DWORD
    - vdata: 0

wsl-set-uac-2-download-only:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
    - vname: PromptOnSecureDesktop
    - vtype: REG_DWORD
    - vdata: 0

wsl-powershell-stager-download-only:
  file.managed:
    - name: '{{ downloads }}\wsl\wsl-after-reboot.ps1'
    - source: salt://bitcurator/downloads/wsl/wsl.ps1
    - win_inheritance: True
    - makedirs: True
    - require:
      - reg: powershell-execution-policy-download-only
      - reg: powershell-execution-policy-path-download-only
      - reg: wsl-set-uac-1-download-only
      - reg: wsl-set-uac-2-download-only

wsl-config-stager-download-only:
  file.managed:
    - name: '{{ downloads }}\wsl\wsl-config.cmd'
    - source: salt://bitcurator/downloads/wsl/wsl-config.cmd
    - win_inheritance: True
    - makedirs: True
    - require:
      - reg: powershell-execution-policy-download-only
      - reg: powershell-execution-policy-path-download-only
      - reg: wsl-set-uac-1-download-only
      - reg: wsl-set-uac-2-download-only
      - file: wsl-powershell-stager-download-only

wsl-powershell-stager-customize-download-only:
  file.replace:
    - name: '{{ downloads }}\wsl\wsl-after-reboot.ps1'
    - pattern: _this_user_
    - repl: {{ user }}
    - count: 1
    - require:
      - file: wsl-powershell-stager-download-only

wsl-powershell-stager-customize-path-download-only:
  file.replace:
    - name: '{{ downloads }}\wsl\wsl-after-reboot.ps1'
    - pattern: _this_path_
    - repl: {{ inpath | regex_escape }}
    - count: 1
    - require:
      - file: wsl-powershell-stager-download-only
      - file: wsl-powershell-stager-customize-download-only

wsl-powershell-stager-customize-pillar-download-only:
  file.replace:
    - name: '{{ downloads }}\wsl\wsl-after-reboot.ps1'
    - pattern: _this_choice_
    - repl: {{ wsl_choice | regex_escape }}
    - count: 1
    - require:
      - file: wsl-powershell-stager-download-only
      - file: wsl-powershell-stager-customize-download-only
      - file: wsl-powershell-stager-customize-path-download-only

wsl-powershell-stager-customize-title-download-only:
  file.replace:
    - name: '{{ downloads }}\wsl\wsl-after-reboot.ps1'
    - pattern: _this_distro_
    - repl: {{ wsl_text }}
    - count: 1
    - require:
      - file: wsl-powershell-stager-download-only
      - file: wsl-powershell-stager-customize-download-only
      - file: wsl-powershell-stager-customize-path-download-only
      - file: wsl-powershell-stager-customize-pillar-download-only

wsl-powershell-stager-customize-downloads-download-only:
  file.replace:
    - name: '{{ downloads }}\wsl\wsl-after-reboot.ps1'
    - pattern: _this_downloads_
    - repl: '{{ downloads | replace("\\", "\\\\") }}'
    - count: 1
    - require:
      - file: wsl-powershell-stager-download-only
      - file: wsl-powershell-stager-customize-download-only
      - file: wsl-powershell-stager-customize-path-download-only
      - file: wsl-powershell-stager-customize-pillar-download-only
      - file: wsl-powershell-stager-customize-title-download-only

wsl-cmd-stager-download-only:
  file.replace:
    - name: '{{ downloads }}\wsl\wsl-config.cmd'
    - pattern: _this_path_
    - repl: '{{ downloads | replace("\\", "\\\\") }}\\wsl'
    - count: 1
    - require:
      - file: wsl-powershell-stager-download-only
      - file: wsl-powershell-stager-customize-download-only
      - file: wsl-powershell-stager-customize-path-download-only
      - file: wsl-powershell-stager-customize-pillar-download-only
      - file: wsl-powershell-stager-customize-downloads-download-only

wsl-config-run-on-reboot-download-only:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce
    - vname: "BitCurator WSL Config"
    - vtype: REG_SZ
    - vdata: 'C:\Windows\system32\cmd.exe /q /c {{ downloads }}\wsl\wsl-config.cmd'
    - require:
      - cmd: wsl-install-download-only
      - file: wsl-config-stager-download-only
      - file: wsl-cmd-stager-download-only
      - file: wsl-powershell-stager-download-only
      - file: wsl-powershell-stager-customize-download-only
      - file: wsl-powershell-stager-customize-path-download-only
      - file: wsl-powershell-stager-customize-title-download-only

wsl-log-append-download-only:
  file.append:
    - name: 'C:\bitcurator-saltstack-{{ version|trim }}-downloads-wsl.log'
    - text: 'GOING FOR REBOOT NOW'
    - require:
      - reg: wsl-config-run-on-reboot-download-only

system-restart-download-only:
  system.reboot:
    - timeout: 0
    - in_seconds: True
    - only_on_pending_reboot: False
    - require:
      - cmd: wsl-install-download-only
      - file: wsl-config-stager-download-only
      - file: wsl-cmd-stager-download-only
      - file: wsl-powershell-stager-download-only
      - file: wsl-powershell-stager-customize-download-only
      - file: wsl-powershell-stager-customize-path-download-only
      - file: wsl-powershell-stager-customize-pillar-download-only
      - file: wsl-powershell-stager-customize-title-download-only
      - reg: wsl-config-run-on-reboot-download-only
