#!/bin/sh
export EDITOR=nvim
export BROWSER=chromium

# Java/Scala
export JAVA_OPTS="$JAVA_OPTS 
  -Dscala.color
  -XX:InitialHeapSize=1024m
  -XX:MaxHeapSize=8192m
  -XX:+CMSClassUnloadingEnabled"

export SBT_OPTS=$JAVA_OPTS

# See https://wiki.archlinux.org/index.php/Qt#Configuration_of_Qt5_apps_under_environments_other_than_KDE
# Requires that qt5ct package is installed
export QT_QPA_PLATFORMTHEME=qt5ct

export XDG_CONFIG_HOME="$HOME/.config" 
