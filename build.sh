#!/bin/bash

set -o pipefail -eu

rm -Rf Takumar*
mkdir Takumar

cp Credits.rtf Takumar/

gcc  -O3 -prebind -mmacosx-version-min=11.0 \
  -o sleepwatcher sleepwatcher_2.2.1/sources/sleepwatcher.c \
  -framework IOKit -framework CoreFoundation

platypus \
  --name Takumar \
  --interface-type 'None' \
  --app-icon Camera_31090.icns \
  --interpreter /usr/bin/perl \
  --app-version 1.0.0 \
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
