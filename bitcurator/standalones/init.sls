include:
  - bitcurator.standalones.antiword
  - bitcurator.standalones.demystify-lite
  - bitcurator.standalones.droid
  - bitcurator.standalones.exiftool
  - bitcurator.standalones.ffmpeg
  - bitcurator.standalones.filelistcreator
  - bitcurator.standalones.filelist
  - bitcurator.standalones.fits
  - bitcurator.standalones.fluxengine
  - bitcurator.standalones.hashdeep
  - bitcurator.standalones.hashmyfiles
  - bitcurator.standalones.jdupes
  - bitcurator.standalones.jhove
  - bitcurator.standalones.kryoflux
  - bitcurator.standalones.mediainfo-cli
  - bitcurator.standalones.mupdf
  - bitcurator.standalones.nsrllookup
  - bitcurator.standalones.rawcooked
  - bitcurator.standalones.rclone
  - bitcurator.standalones.siegfried
  - bitcurator.standalones.tika

bitcurator-standalones:
  test.nop:
    - name: bitcurator-standalones
    - require:
      - sls: bitcurator.standalones.antiword
      - sls: bitcurator.standalones.demystify-lite
      - sls: bitcurator.standalones.droid
      - sls: bitcurator.standalones.exiftool
      - sls: bitcurator.standalones.ffmpeg
      - sls: bitcurator.standalones.filelistcreator
      - sls: bitcurator.standalones.filelist
      - sls: bitcurator.standalones.fits
      - sls: bitcurator.standalones.fluxengine
      - sls: bitcurator.standalones.hashdeep
      - sls: bitcurator.standalones.hashmyfiles
      - sls: bitcurator.standalones.jdupes
      - sls: bitcurator.standalones.jhove
      - sls: bitcurator.standalones.kryoflux
      - sls: bitcurator.standalones.mediainfo-cli
      - sls: bitcurator.standalones.mupdf
      - sls: bitcurator.standalones.nsrllookup
      - sls: bitcurator.standalones.rawcooked
      - sls: bitcurator.standalones.rclone
      - sls: bitcurator.standalones.siegfried
      - sls: bitcurator.standalones.tika

