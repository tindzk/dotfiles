#!/bin/sh
export EDITOR=nvim
export PATH=$HOME/bin:~/.local/share/coursier/bin:$PATH
export LD_LIBRARY_PATH=~/usr/lib:$LD_LIBRARY_PATH
export JAVA_OPTS="-XX:InitialHeapSize=128m -XX:MaxHeapSize=1024m"
