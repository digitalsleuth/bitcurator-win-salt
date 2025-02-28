{% set user = salt['pillar.get']('bitcurator_user', 'bcadmin') %}
{% set release = grains['osrelease'] %}
{% set home = "C:\\Users\\" + user %}
{% set startup_folder = home + "\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\" %}
{% set SYSTEMDRIVE = salt['environ.get']('SYSTEMDRIVE') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set START_MENU = PROGRAMDATA + '\Microsoft\Windows\Start Menu\Programs' %}
{% set PS_PATH = salt['environ.get']('PSMODULEPATH').split(";")[0] %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set profile_pictures = ['user.png', 'user.bmp', 'user-32.png', 'user-40.png', 'user-48.png', 'user-192.png'] %}
{% set portals_configs = ['portals.ptl','globalsettings.ptl','license.ptl'] %}
{% set vert = salt['cmd.powershell']('[int]((Get-CimInstance CIM_VideoController | Select -expand CurrentVerticalResolution) / 5)') | int %}
{% set horiz = salt['cmd.powershell']('[int]((Get-CimInstance CIM_VideoController | Select -expand CurrentHorizontalResolution) / 8)') | int %}
{% set hspacer = horiz + 1 %}
{% set h1 = horiz  %}
{% set h2 = h1 + hspacer %}
{% set h3 = h2 + hspacer %}
{% set h4 = h3 + hspacer %}
{% set h5 = h4 + hspacer %}
{% set h6 = h5 + hspacer %}
{% set vspacer = vert + 1 %}
{% set v1 = vert %}
{% set v2 = v1 + vspacer %}
{% set v3 = v2 + vspacer %}
{% set horizontals = [(h1, "H1"), (h2, "H2"), (h3, "H3"), (h4, "H4"), (h5, "H5"), (h6, "H6")] %}
{% set verticals = [(v1, "V1"), (v2, "V2"), (v3, "V3")] %}
{% set dwidth = horiz * 2 %}
{% set start_folders = [('01','Archival'),
                        ('02','Browsers'),
                        ('03','Documents and Editors'),
                        ('04','Raw Parsers and Decoders'),
                        ('05','Terminals'),
                        ('06','Utilities'),
                       ] %}
{% set shortcuts = [
                    ('Archival', ['Advanced Renamer\Advanced Renamer','Beyond Compare 5','Bulk Extractor 1.5.5\BEViewer with Bulk Extractor 1.5.5 (64-bit)','Bulk Rename Utility\Bulk Rename Utility','Demystify-Lite','DROID','dupeGuru\dupeGuru','Duplicate Cleaner 5\Duplicate Cleaner Pro 5','ePADD','Exact Audio Copy\Exact Audio Copy','FilelistCreator','FileZilla FTP Client\FileZilla','AccessData\FTK Imager\FTK Imager','GIMP 2.10.38','HashMyFiles','HFSExplorer\HFSExplorer','IsoBuster\IsoBuster (64bit)','jhove','MKVToolNix\MKVToolNiv','mupdf','OpenRefine\OpenRefine','PowerGREP 5','TreeSize\TreeSize','vRenamer','WinDirStat','WinMerge\WinMerge']),
                    ('Browsers', ['Firefox','Google Chrome','Microsoft Edge']),
                    ('Documents and Editors', ['LibreOffice\LibreOffice','Notepad++','Sublime Text']),
                    ('Raw Parsers and Decoders', ['HHD Hex Editor Neo\Hex Editor Neo','HxD Hex Editor\HxD']),
                    ('Terminals', ['Terminal','WSL']),
                    ('Utilities', ['7-Zip\\7-Zip File Manager','PowerToys (Preview)\PowerToys (Preview)','Everything','Glossary Generator','Google Earth Pro','Hasher','Hash Generator','IrfanView\IrfanView 64 4.62','iTunes\iTunes','Monolith Notes',"Nuix\\Nuix Evidence Mover\\Nuix Evidence Mover",'Rufus','Sysinternals','Tableau\Tableau Firmware Update\Tableau Firmware Update','TeraCopy','USB Write Blocker','VeraCrypt 1.26.7\VeraCrypt','Oracle VM VirtualBox\Oracle VM VirtualBox','VideoLAN\VLC media player','CDSG\WriteBlocking Validation Utility\WriteBlocking Validation Utility','WinMerge\WinMerge']),
                   ] %}

include:
  - bitcurator.packages.portals
  - bitcurator.config.user

bitcurator-theme-wallpaper-source:
  file.managed:
    - name: '{{ SYSTEMDRIVE }}\bitcurator-theme\bitcurator-wallpaper.png'
    - source: salt://bitcurator/theme/bitcurator/bitcurator-wallpaper.png
    - skip_verify: True
    - makedirs: True
    - win_inheritance: True

{% for file in profile_pictures %}

bitcurator-theme-profile-picture-backup-{{ file }}:
  file.managed:
    - name: '{{ PROGRAMDATA }}\Microsoft\User Account Pictures\{{ file }}.bak'
    - source: '{{ PROGRAMDATA }}\Microsoft\User Account Pictures\{{ file }}'
    - skip_verify: True

bitcurator-theme-profile-picture-copy-{{ file }}:
  file.managed:
    - name: '{{ PROGRAMDATA }}\Microsoft\User Account Pictures\{{ file }}'
    - source: salt://bitcurator/theme/bitcurator/{{ file }}
    - skip_verify: True
    - replace: True
    - require:
      - file: bitcurator-theme-profile-picture-backup-{{ file }}

{% endfor %}

bitcurator-theme-default-profile-picture:
  reg.present:
    - name: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer
    - vname: UseDefaultTile
    - vtype: REG_DWORD
    - vdata: 1

{% for folder, tool_list in shortcuts %}
shortcut-{{ folder }}:
  file.directory:
    - name: '{{ inpath }}\Portals\{{ folder }}'
    - makedirs: True
    - replace: True
    - win_inheritance: True
{% for tool in tool_list %}
{% set shortcut = tool + ".lnk" %}
shortcut-{{ folder }}-{{ shortcut }}:
  file.copy:
    - name: '{{ inpath }}\Portals\{{ folder }}\'
    - source: '{{ START_MENU }}\{{ shortcut }}'
    - preserve: True
    - subdir: True
    - onlyif:
      - fun: file.file_exists
        path: '{{ START_MENU }}\{{ shortcut }}'
{% endfor %}
{% endfor %}

portals-end-process:
  cmd.run:
    - name: 'taskkill /F /IM "Portals.exe"'
    - bg: True
    - require:
      - sls: bitcurator.packages.portals

{% for config in portals_configs %}
portals-{{ config }}-copy:
  file.managed:
    - name: '{{ home }}\AppData\Local\Portals\{{ config }}'
    - source: salt://bitcurator/theme/bitcurator/{{ config }}
    - makedirs: True
    - replace: True
    - require:
      - user: user-{{ user }}
      - sls: bitcurator.packages.portals

portals-{{ config }}-placeholder-replace:
  file.replace:
    - name: '{{ home }}\AppData\Local\Portals\{{ config }}'
    - pattern: PLACEHOLDER_PATH
    - repl: {{ inpath | regex_escape }}
    - require:
      - file: portals-{{ config }}-copy
{% endfor %}

{% for hval, hph in horizontals %}
portals-replace-{{ hph }}:
  file.replace:
    - name: '{{ home }}\AppData\Local\Portals\portals.ptl'
    - pattern: {{ hph }}
    - repl: {{ hval }}
{% endfor %}

{% for vval, vph in verticals %}
portals-replace-{{ vph }}:
  file.replace:
    - name: '{{ home }}\AppData\Local\Portals\portals.ptl'
    - pattern: {{ vph }}
    - repl: {{ vval }}
{% endfor %}

portals-replace-width:
  file.replace:
    - name: '{{ home }}\AppData\Local\Portals\portals.ptl'
    - pattern: PWIDTH
    - repl: {{ horiz }}

portals-replace-dwidth:
  file.replace:
    - name: '{{ home }}\AppData\Local\Portals\portals.ptl'
    - pattern: DWIDTH
    - repl: {{ dwidth }}

portals-replace-height:
  file.replace:
    - name: '{{ home }}\AppData\Local\Portals\portals.ptl'
    - pattern: PHEIGHT
    - repl: {{ vert }}

bitcurator-theme-start-layout-file:
  file.managed:
    - name: '{{ SYSTEMDRIVE }}\bitcurator-theme\BitCurator-StartLayout.xml'
    - source: salt://bitcurator/config/layout/BitCurator-StartLayout.xml
    - win_inheritance: True
    - makedirs: True

bitcurator-theme-start-layout-replace-placeholder:
  file.replace:
    - name: '{{ SYSTEMDRIVE }}\bitcurator-theme\BitCurator-StartLayout.xml'
    - pattern: PLACEHOLDER_PATH
    - repl: {{ inpath | regex_escape }}
    - require:
      - file: bitcurator-theme-start-layout-file

{% for number, folder in start_folders %}
bitcurator-theme-start-shortcut-{{ folder }}:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\{{ number }} - {{ folder }}.lnk'
    - target: 'C:\Windows\explorer.exe'
    - arguments: '{{ inpath }}\Portals\{{ folder }}'
    - force: True
{% endfor %}

{% if release != '11' %}

bitcurator-theme-start-layout-enable-gpo:
  lgpo.set:
    - user_policy:
        "Start Menu and Taskbar\\Start Layout":
          "Start Layout File":
             '{{ SYSTEMDRIVE }}\bitcurator-theme\BitCurator-StartLayout.xml'
    - computer_policy:
        "Start Menu and Taskbar\\Start Layout":
          "Start Layout File":
             '{{ SYSTEMDRIVE }}\bitcurator-theme\BitCurator-StartLayout.xml'

{% endif %}

bitcurator-theme-stager:
  file.managed:
    - name: '{{ SYSTEMDRIVE }}\bitcurator-theme\theme-config.cmd'
    - win_inheritance: True
    - makedirs: True
    - replace: True
    - contents: |
        @echo off
        setlocal EnableDelayedExpansion
        title Disable Locked Start Layout - Enable Theme
        %1 %2 mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :runas","","runas",1)(window.close)&goto :eof
        :runas
        echo Forcing update of GPO's
        gpupdate /force
        timeout /t 3 /nobreak 1>nul
        echo Disabling locked start menu layout
        {% if release != '11' %}
        reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer /v LockedStartLayout /t REG_DWORD /d 0 /f 1>nul
        reg add HKCU\Software\Policies\Microsoft\Windows\Explorer /v LockedStartLayout /t REG_DWORD /d 0 /f 1>nul
        {% endif %}
        reg add "HKCU\Control Panel\Colors" /v Background /t REG_SZ /d "69 130 180" /f 1>nul
        reg add "HKCU\Control Panel\Desktop" /v WallPaper /t REG_SZ /d "{{ SYSTEMDRIVE }}\bitcurator-theme\bitcurator-wallpaper.png" /f 1>nul
        reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d "10" /f 1>nul
        reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d "0" /f 1>nul
        RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True
        echo Display reset exited with error code %ERRORLEVEL%
        reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v Portals /t REG_SZ /d "C:\Program Files\Portals\Portals.exe" /f 1>nul
        {% if release == '11' %}
        reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v TaskbarAl /t REG_DWORD /d "0" /f 1>nul
        {% endif %}
        echo Restarting Explorer...
        timeout /t 1 /nobreak 1>nul
        taskkill /F /IM explorer.exe & start explorer
        {% if user != salt['environ.get']('USERNAME') %}
        echo Debloating Windows for {{ user }}
        powershell -nop -ep Bypass -File "{{ PS_PATH }}\\Win10Debloat\\Win10.ps1" -include "{{ PS_PATH }}\\Win10Debloat\\Win10.psm1" -preset "{{ PS_PATH }}\\Win10Debloat\\debloat.preset"
        {% endif %}
        echo Finished - cleaning up
        timeout /t 3 /nobreak 1>nul
        RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True
        exit

{% if user == salt['environ.get']('USERNAME') %}

bitcurator-theme-stager-on-reboot-hkcu:
  reg.present:
    - name: HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
    - vname: "BitCurator Theme Config"
    - vtype: REG_SZ
    - vdata: '{{ SYSTEMDRIVE }}\bitcurator-theme\theme-config.cmd'
    - require:
      - file: bitcurator-theme-stager

bitcurator-theme-suggest-reboot:
  cmd.run:
    - name: 'msg %username% "The theme will be fully applied once you log off then log back in."'
    - shell: cmd
    - require:
      - file: bitcurator-theme-stager
      - reg: bitcurator-theme-stager-on-reboot-hkcu

{% else %}

Load NTUSER.DAT for {{ user }}:
  cmd.run:
    - name: reg load HKU\{{ user }} C:\Users\{{ user }}\NTUSER.DAT
    - shell: cmd

Add RunOnce key to {{ user }}:
  reg.present:
    - name: HKU\{{ user }}\Software\Microsoft\Windows\CurrentVersion\RunOnce
    - vname: "BitCurator Theme Config"
    - vtype: REG_SZ
    - vdata: '{{ SYSTEMDRIVE }}\bitcurator-theme\theme-config.cmd'
    - require:
      - cmd: Load NTUSER.DAT for {{ user }}

Unload NTUSER.DAT for {{ user }}:
  cmd.run:
    - name: reg unload HKU\{{ user }}
    - shell: cmd
    - require:
      - cmd: Load NTUSER.DAT for {{ user }}
      - reg: Add RunOnce key to {{ user }}

bitcurator-theme-suggest-reboot:
  cmd.run:
    - name: 'msg %username% "The theme will be fully applied for {{ user }} the next time they log on."'
    - shell: cmd
    - require:
      - file: bitcurator-theme-stager
      - cmd: Load NTUSER.DAT for {{ user }}
      - reg: Add RunOnce key to {{ user }}
      - cmd: Unload NTUSER.DAT for {{ user }}

{% endif %}
