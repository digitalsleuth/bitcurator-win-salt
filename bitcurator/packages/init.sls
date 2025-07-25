include:
  - bitcurator.packages.python3
  - bitcurator.packages.python3-requirements
  - bitcurator.packages.7zip
  - bitcurator.packages.advanced-renamer
  - bitcurator.packages.bagger
  - bitcurator.packages.bulk-extractor
  - bitcurator.packages.bulk-rename-utility
  - bitcurator.packages.clamav
  - bitcurator.packages.dart
  - bitcurator.packages.dupeguru
  - bitcurator.packages.epadd
  - bitcurator.packages.exact-audio-copy
  - bitcurator.packages.filezilla-client
  - bitcurator.packages.ftk-imager
  - bitcurator.packages.gimp
  - bitcurator.packages.hfs-explorer
  - bitcurator.packages.isobuster
  - bitcurator.packages.karens-directory-printer
  - bitcurator.packages.libreoffice
  - bitcurator.packages.mediainfo
  - bitcurator.packages.mkvtoolnix
  - bitcurator.packages.openrefine
  - bitcurator.packages.powergrep
  - bitcurator.packages.vrenamer
  - bitcurator.packages.windirstat
  - bitcurator.packages.beyond-compare
  - bitcurator.packages.duplicate-cleaner
  - bitcurator.packages.openhashtab
  - bitcurator.packages.sublime-text
  - bitcurator.packages.teracopy
  - bitcurator.packages.treesize-pro
  - bitcurator.packages.vlc
  - bitcurator.packages.winmerge
  - bitcurator.packages.jre8
  - bitcurator.packages.free-hex-editor-neo
  - bitcurator.packages.notepad-plus-plus
  - bitcurator.packages.chrome
  - bitcurator.packages.firefox
  - bitcurator.packages.portals

bitcurator-packages:
  test.nop:
    - name: bitcurator-packages
    - require:
      - sls: bitcurator.packages.python3
      - sls: bitcurator.packages.python3-requirements
      - sls: bitcurator.packages.7zip
      - sls: bitcurator.packages.advanced-renamer
      - sls: bitcurator.packages.bagger
      - sls: bitcurator.packages.bulk-extractor
      - sls: bitcurator.packages.bulk-rename-utility
      - sls: bitcurator.packages.clamav
      - sls: bitcurator.packages.dart
      - sls: bitcurator.packages.dupeguru
      - sls: bitcurator.packages.epadd
      - sls: bitcurator.packages.exact-audio-copy
      - sls: bitcurator.packages.filezilla-client
      - sls: bitcurator.packages.ftk-imager
      - sls: bitcurator.packages.gimp
      - sls: bitcurator.packages.hfs-explorer
      - sls: bitcurator.packages.isobuster
      - sls: bitcurator.packages.karens-directory-printer
      - sls: bitcurator.packages.libreoffice
      - sls: bitcurator.packages.mediainfo
      - sls: bitcurator.packages.mkvtoolnix
      - sls: bitcurator.packages.openrefine
      - sls: bitcurator.packages.powergrep
      - sls: bitcurator.packages.vrenamer
      - sls: bitcurator.packages.windirstat
      - sls: bitcurator.packages.beyond-compare
      - sls: bitcurator.packages.duplicate-cleaner
      - sls: bitcurator.packages.openhashtab
      - sls: bitcurator.packages.sublime-text
      - sls: bitcurator.packages.teracopy
      - sls: bitcurator.packages.treesize-pro
      - sls: bitcurator.packages.vlc
      - sls: bitcurator.packages.winmerge
      - sls: bitcurator.packages.jre8
      - sls: bitcurator.packages.free-hex-editor-neo
      - sls: bitcurator.packages.notepad-plus-plus
      - sls: bitcurator.packages.chrome
      - sls: bitcurator.packages.firefox
      - sls: bitcurator.packages.portals
