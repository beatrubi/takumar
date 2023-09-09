#!/bin/bash

set -o pipefail -eu

rm -Rf Takumar*
mkdir Takumar

cp Credits.rtf Takumar/

platypus \
  --name Takumar \
  --interface-type 'None' \
  --app-icon Camera_31090.icns \
  --interpreter /usr/bin/perl \
  --app-version 0.01 \
  --author "Beat Rubischon" \
  --bundled-file Credits.rtf \
  --bundled-file Pictures \
  --bundled-file sleepwatcher \
  --quit-after-execution \
  --optimize-nib \
  --overwrite \
  takumar.pl \
  Takumar/Takumar.app

hdiutil create -fs HFS+ -srcfolder Takumar -volname Takumar Takumar-temp.dmg
hdiutil convert Takumar-temp.dmg -format UDZO -o Takumar.dmg
