#!/bin/sh
export EDITOR=nvim

# Lua/Torch
export PATH=$PATH:$HOME/.luarocks/bin
export PATH=$PATH:$HOME/torch/install/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/torch/install/lib
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$HOME/torch/install/lib

# cuDNN
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/cuda/lib64
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$HOME/cuda/lib64

# Java/Scala
export JAVA_OPTS="$JAVA_OPTS 
  -Dscala.color
  -XX:InitialHeapSize=1024m
  -XX:MaxHeapSize=4096m
  -XX:+CMSClassUnloadingEnabled"

export SBT_OPTS=$JAVA_OPTS

# See https://wiki.archlinux.org/index.php/Qt#Configuration_of_Qt5_apps_under_environments_other_than_KDE
export QT_QPA_PLATFORMTHEME=qt5ct

export XDG_CONFIG_HOME="$HOME/.config" 
