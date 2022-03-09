#!/bin/sh
export EDITOR=nvim
export PATH=~/.yarn/bin:$HOME/bin:~/.local/share/coursier/bin:$PATH
export LD_LIBRARY_PATH=~/usr/lib:$LD_LIBRARY_PATH
export JAVA_OPTS="-XX:InitialHeapSize=64m -XX:MaxHeapSize=512m"
