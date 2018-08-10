#!/bin/sh
export EDITOR=nvim
export BROWSER=firefox

export IDEA_JDK=/usr/lib/jvm/intellij-jdk
export JAVA_OPTS="-XX:InitialHeapSize=1024m -XX:MaxHeapSize=8192m"

# See https://wiki.archlinux.org/index.php/Qt#Configuration_of_Qt5_apps_under_environments_other_than_KDE
# Requires that qt5ct package is installed
export QT_QPA_PLATFORMTHEME=qt5ct

# HiDPI support
# See https://wiki.archlinux.org/index.php/HiDPI
export GDK_SCALE=2
export QT_SCALE_FACTOR=2

export XDG_CONFIG_HOME="$HOME/.config"
