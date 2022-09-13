#!/bin/sh
export EDITOR=nvim
export PATH=$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/bin:$HOME/.local/share/coursier/bin:$PATH
export LD_LIBRARY_PATH=~/usr/lib:$LD_LIBRARY_PATH
export JAVA_OPTS="-XX:InitialHeapSize=64m -XX:MaxHeapSize=512m"

if [[ "$OSTYPE" == "darwin"* ]]; then
	export JAVA_HOME=`/usr/libexec/java_home -v 11`
	export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
fi
