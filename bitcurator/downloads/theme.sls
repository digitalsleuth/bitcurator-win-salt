# Name: Theme (download only)
# Website: https://github.com/digitalsleuth/bitcurator-win-salt
# Description: Downloads what the BitCurator theme needs so it can be applied by an offline install
# Category: Requirements
# Author: Corey Forman (digitalsleuth)
# License: GNU General Public License v3+
# Version: 0.0
# Notes: The theme itself is never applied by a download - bitcurator.theme.bitcurator does that for the install and offline states

include:
  - bitcurator.downloads.packages.portals

theme-states-download-only:
  test.nop:
    - require:
      - sls: bitcurator.downloads.packages.portals
