include:
  - bitcurator.downloads.packages.7zip
  - bitcurator.downloads.packages.advanced-renamer
  - bitcurator.downloads.packages.bagger
  - bitcurator.downloads.packages.bulk-extractor
  - bitcurator.downloads.packages.bulk-rename-utility
  - bitcurator.downloads.packages.clamav
  - bitcurator.downloads.packages.dart
  - bitcurator.downloads.packages.dupeguru
  - bitcurator.downloads.packages.epadd
  - bitcurator.downloads.packages.exact-audio-copy
  - bitcurator.downloads.packages.filezilla-client
  - bitcurator.downloads.packages.ftk-imager
  - bitcurator.downloads.packages.gimp
  - bitcurator.downloads.packages.hfs-explorer
  - bitcurator.downloads.packages.isobuster
  - bitcurator.downloads.packages.karens-directory-printer
  - bitcurator.downloads.packages.libreoffice
  - bitcurator.downloads.packages.mediainfo
  - bitcurator.downloads.packages.mkvtoolnix
  - bitcurator.downloads.packages.openrefine
  - bitcurator.downloads.packages.powergrep
  - bitcurator.downloads.packages.vrenamer
  - bitcurator.downloads.packages.windirstat
  - bitcurator.downloads.packages.beyond-compare
  - bitcurator.downloads.packages.duplicate-cleaner
  - bitcurator.downloads.packages.openhashtab
  - bitcurator.downloads.packages.sublime-text
  - bitcurator.downloads.packages.teracopy
  - bitcurator.downloads.packages.treesize-pro
  - bitcurator.downloads.packages.vlc
  - bitcurator.downloads.packages.winmerge
  - bitcurator.downloads.packages.jre8
  - bitcurator.downloads.packages.free-hex-editor-neo
  - bitcurator.downloads.packages.notepad-plus-plus
  - bitcurator.downloads.packages.chrome
  - bitcurator.downloads.packages.firefox
  - bitcurator.downloads.packages.portals
  - bitcurator.downloads.standalones.antiword
  - bitcurator.downloads.standalones.demystify-lite
  - bitcurator.downloads.standalones.droid
  - bitcurator.downloads.standalones.exiftool
  - bitcurator.downloads.standalones.ffmpeg
  - bitcurator.downloads.standalones.filelistcreator
  - bitcurator.downloads.standalones.filelist
  - bitcurator.downloads.standalones.fits
  - bitcurator.downloads.standalones.fluxengine
  - bitcurator.downloads.standalones.hashdeep
  - bitcurator.downloads.standalones.hashmyfiles
  - bitcurator.downloads.standalones.jdupes
  - bitcurator.downloads.standalones.jhove
  - bitcurator.downloads.standalones.kryoflux
  - bitcurator.downloads.standalones.mediainfo-cli
  - bitcurator.downloads.standalones.mupdf
  - bitcurator.downloads.standalones.nsrllookup
  - bitcurator.downloads.standalones.rawcooked
  - bitcurator.downloads.standalones.rclone
  - bitcurator.downloads.standalones.siegfried
  - bitcurator.downloads.standalones.tika
  - bitcurator.downloads.installers.hxd
  - bitcurator.downloads.installers.windows-terminal
  - bitcurator.downloads.installers.windows-winget

bitcurator-downloads:
  test.nop:
    - name: bitcurator-downloads
    - require:
      - sls: bitcurator.downloads.packages.7zip
      - sls: bitcurator.downloads.packages.advanced-renamer
      - sls: bitcurator.downloads.packages.bagger
      - sls: bitcurator.downloads.packages.bulk-extractor
      - sls: bitcurator.downloads.packages.bulk-rename-utility
      - sls: bitcurator.downloads.packages.clamav
      - sls: bitcurator.downloads.packages.dart
      - sls: bitcurator.downloads.packages.dupeguru
      - sls: bitcurator.downloads.packages.epadd
      - sls: bitcurator.downloads.packages.exact-audio-copy
      - sls: bitcurator.downloads.packages.filezilla-client
      - sls: bitcurator.downloads.packages.ftk-imager
      - sls: bitcurator.downloads.packages.gimp
      - sls: bitcurator.downloads.packages.hfs-explorer
      - sls: bitcurator.downloads.packages.isobuster
      - sls: bitcurator.downloads.packages.karens-directory-printer
      - sls: bitcurator.downloads.packages.libreoffice
      - sls: bitcurator.downloads.packages.mediainfo
      - sls: bitcurator.downloads.packages.mkvtoolnix
      - sls: bitcurator.downloads.packages.openrefine
      - sls: bitcurator.downloads.packages.powergrep
      - sls: bitcurator.downloads.packages.vrenamer
      - sls: bitcurator.downloads.packages.windirstat
      - sls: bitcurator.downloads.packages.beyond-compare
      - sls: bitcurator.downloads.packages.duplicate-cleaner
      - sls: bitcurator.downloads.packages.openhashtab
      - sls: bitcurator.downloads.packages.sublime-text
      - sls: bitcurator.downloads.packages.teracopy
      - sls: bitcurator.downloads.packages.treesize-pro
      - sls: bitcurator.downloads.packages.vlc
      - sls: bitcurator.downloads.packages.winmerge
      - sls: bitcurator.downloads.packages.jre8
      - sls: bitcurator.downloads.packages.free-hex-editor-neo
      - sls: bitcurator.downloads.packages.notepad-plus-plus
      - sls: bitcurator.downloads.packages.chrome
      - sls: bitcurator.downloads.packages.firefox
      - sls: bitcurator.downloads.packages.portals
      - sls: bitcurator.downloads.standalones.antiword
      - sls: bitcurator.downloads.standalones.demystify-lite
      - sls: bitcurator.downloads.standalones.droid
      - sls: bitcurator.downloads.standalones.exiftool
      - sls: bitcurator.downloads.standalones.ffmpeg
      - sls: bitcurator.downloads.standalones.filelistcreator
      - sls: bitcurator.downloads.standalones.filelist
      - sls: bitcurator.downloads.standalones.fits
      - sls: bitcurator.downloads.standalones.fluxengine
      - sls: bitcurator.downloads.standalones.hashdeep
      - sls: bitcurator.downloads.standalones.hashmyfiles
      - sls: bitcurator.downloads.standalones.jdupes
      - sls: bitcurator.downloads.standalones.jhove
      - sls: bitcurator.downloads.standalones.kryoflux
      - sls: bitcurator.downloads.standalones.mediainfo-cli
      - sls: bitcurator.downloads.standalones.mupdf
      - sls: bitcurator.downloads.standalones.nsrllookup
      - sls: bitcurator.downloads.standalones.rawcooked
      - sls: bitcurator.downloads.standalones.rclone
      - sls: bitcurator.downloads.standalones.siegfried
      - sls: bitcurator.downloads.standalones.tika
      - sls: bitcurator.downloads.installers.hxd
      - sls: bitcurator.downloads.installers.windows-terminal
      - sls: bitcurator.downloads.installers.windows-winget
