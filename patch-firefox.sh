#!/usr/bin/env sh
#
# From https://github.com/glacambre/firefox-patches/issues/1
#
# Needed for https://github.com/glacambre/firenvim/
#

sudo perl -i -pne 's/reserved="true"/               /g' /usr/lib/firefox/browser/omni.ja
find ~/.cache/mozilla/firefox -type d -name startupCache | xargs rm -rf
