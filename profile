#!/bin/sh
export EDITOR=nvim
export PATH=$HOME/.cargo/bin:$HOME/.rye/shims:$HOME/.yarn/bin:$HOME/bin:$HOME/.local/share/coursier/bin:$PATH
export LD_LIBRARY_PATH=~/usr/lib:$LD_LIBRARY_PATH
export JAVA_OPTS="-XX:InitialHeapSize=64m -XX:MaxHeapSize=512m"

if [[ "$OSTYPE" == "darwin"* ]]; then
	export JAVA_HOME=`/usr/libexec/java_home -v 11`
	export PATH="$JAVA_HOME/bin:$PATH"
	export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
	export PATH="/opt/homebrew/opt/uutils-coreutils/libexec/uubin:$PATH"
	export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

	export NVM_DIR="$HOME/.nvm"
	[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
	[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \
		. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi

. "$HOME/.cargo/env"
