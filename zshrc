# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Enter directories without `cd` command
setopt autocd

# Allow comments in commands using hashtag
setopt interactivecomments

# Spelling corrections
setopt correct

# Disable beeping
unsetopt beep

# Enable case-insensitive globbing
unsetopt CASE_GLOB

# Completions
export PATH=$HOME/.bloop:$PATH
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
fpath=($HOME/.bloop/zsh $fpath)
compinit

# Colours
autoload -Uz colors
colors

# Vi mode
bindkey -v

# Auto-completion for kill command
# Adapted from https://gist.github.com/fredw08/1999371
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps xo pid,rss,cmd --sort rss | numfmt --header --from-unit=1024 --to=iec --field 2 | tail +1'

bindkey "^R" history-incremental-search-backward

function zle-line-init zle-keymap-select () {
	# See https://github.com/AguirreIF/urxvt-patchs/blob/master/README.md
	case $KEYMAP in
		vicmd)      print -n -- "\033[2 q";;  # block cursor (normal mode)
		viins|main) print -n -- "\033[6 q";;  # vertical cursor (insert mode)
	esac
}

zle -N zle-line-init
zle -N zle-keymap-select

# Set terminal window and tab/icon title
#
# See also http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
#
# From https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
function title {
	emulate -L zsh
	setopt prompt_subst

	print -Pn "\e]1;$1:q\a" # set tab name

	if [[ "$TERM" != "screen" ]]; then
		print -Pn "\e]2;$2:q\a" # set window name
	fi
}

# Runs before showing the prompt
function omz_termsupport_precmd {
	emulate -L zsh

	# 15 char left truncated PWD
	title "%15<..<%~%<<" "%~"
}

# Runs before executing the command
function omz_termsupport_preexec {
	emulate -L zsh
	setopt extended_glob

	# cmd name only, or if this is sudo/ssh/mosh, the next cmd
	local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|-*)]:gs/%/%%}
	local LINE="${2:gs/%/%%}"

	title '$CMD' '%100>...>$LINE%<<'
}

precmd_functions+=(omz_termsupport_precmd)
preexec_functions+=(omz_termsupport_preexec)

export _git=/usr/bin/git
alias g=$_git
alias gs="$_git status -sb"
alias gsh="$_git show"
alias gb="$_git branch"
alias gf="$_git fetch"
alias gc="$_git commit"
alias gca="$_git commit --amend"
alias gcan="$_git commit --amend --no-edit"
alias gco="$_git checkout"
alias gcl="$_git checkout --theirs"  # Use local file
alias gcr="$_git checkout --ours"    # Use remote file
alias gd="$_git diff"
alias gdc="$_git diff --cached"
alias gl="smerge ."
alias gcp="$_git cherry-pick"
alias gcpc="$_git cherry-pick --continue"
alias gp="$_git push"
# From https://stackoverflow.com/a/56236629/13300239
function gps() { $_git submodule foreach --recursive 'git push' }
function gpo() { $_git push --set-upstream $(git remote | head -n1) $($_git rev-parse --abbrev-ref HEAD) }
alias gpf="$_git push --force-with-lease"
alias gsl="$_git submodule update --init --recursive"
alias gsr="$_git submodule update --init --remote --recursive"
alias gundo="$_git reset HEAD^ --"
alias ga="$_git add"
alias gr="$_git rebase"
alias grc="$_git rebase --continue"

alias p=mpv
alias ls=eza
alias ll="eza --long --git"
alias lt="eza --tree"
alias loc="tokei -f --sort=lines"

alias instructor=$HOME/dev/instructor/instructor
alias b=bloop

alias yt="youtube-dl --all-subs"
alias yta="youtube-dl -f bestaudio"
ytb() { youtube-dl --all-subs --batch-file=$1 }
yts() { youtube-dl --write-auto-sub --sub-lang $1 $2 }
ytp() { youtube-dl "https://www.youtube.com/playlist?list=$1" }

# Create and load virtual Python environment
function penv {
  [ ! -d "venv/" ] && python3 -m venv venv
  source venv/bin/activate
}

alias httpd=miniserve

alias edit-zshrc="nvim $HOME/.zshrc && source $HOME/.zshrc"

grb() { g show $1:$2 > $2 }

#
# Example usage: changeDns "172.17.0.1 8.8.8.8"
#
# The IPs must be space-separated.
#
# From https://serverfault.com/a/1064938
#
function changeDns() {
	ips=$1
	nmcli -g name,type connection  show  --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
	do
		nmcli con mod  "$connection" ipv6.ignore-auto-dns yes
		nmcli con mod  "$connection" ipv4.ignore-auto-dns yes
		nmcli con mod  "$connection" ipv4.dns $ips
		nmcli con down "$connection"
		nmcli con up   "$connection"
	done
}

function rec() {
	time=$(date --iso-8601=minutes)
	ffmpeg -f pulse -i alsa_input.usb-Generic_Realtek_Audio_USB_201701110001-00.analog-stereo -filter:a volume=15dB ~/recordings/$time.ogg
}

function killZombies() {
	kill -HUP `ps -A -ostat,ppid | grep -e '^[Zz]' | awk '{print $2}'`
}

function gitzip {
	# From https://gist.github.com/LeonardoCardoso/6c083b90a8c327d8c82f#gistcomment-3305458
	git archive --prefix ${PWD##*/}/ HEAD -o ../${PWD##*/}-$(date "+%Y-%m-%d-%H-%M-%S").zip
}

alias pubip="curl ifconfig.co/json | jq"

alias .=source
alias '?'="""
echo 'Aliases:
.    source
g    git
gs   git status -sb
gsh  git show
gb   git branch
gf   git fetch
gc   git commit
gca  git commit --amend
gcan git commit --amend --no-edit
gco  git checkout
gcl  git checkout --theirs  # Use local file
gcr  git checkout --ours    # Use remote file
gd   git diff
gdc  git diff --cached
gl   smerge
gcp  git cherry-pick
gcpc git cherry-pick --continue
gp   git push
gpo  git push --set-upstream <default remote> <branch name>
gpf  git push --force-with-lease
gsl  git submodule update --init --recursive           # Checkout latest local submodule
                                                       # Usage: gsl           Checkout all submodules
                                                       # Usage: gsl <module>  Checkout specific submodule
gsr  git submodule update --init --remote --recursive  # Checkout latest remote submodule
gundo  git reset HEAD^ --
ga   git add
gr   git rebase
grc  git rebase --continue
grb  git show \$1:\$2 > \$2     # Restore file <path> from <branch>
                             # Usage: grb <branch> <path>
p    mpv
ls   eza
ll   eza --long --git
lt   eza --tree
loc  tokei -f --sort=lines
b    bloop
e           hx
edit-zshrc  hx $HOME/.zshrc && source $HOME/.zshrc
yt   youtube-dl --all-subs
yta  youtube-dl -f bestaudio
ytb  youtube-dl --all-subs --batch-file=<file>
yts  youtube-dl --write-auto-sub --sub-lang <lang> <url>
ytp  youtube-dl https://www.youtube.com/playlist?list=<id>
penv  python -m venv venv; venv/bin/activate
pld   source venv/bin/activate
httpd miniserve
"""

if [[ -f "/usr/share/fzf/key-bindings.zsh" ]]; then
	# Arch Linux
	source /usr/share/fzf/key-bindings.zsh
elif [[ -f "/usr/share/fzf/shell/key-bindings.zsh" ]]; then
	# Fedora
	source /usr/share/fzf/shell/key-bindings.zsh
else
	source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

source ~/dotfiles/auto-ls.zsh
source ~/.profile
source ~/dotfiles/viper-env.plugin.zsh

alias cd=z
alias pw=motus
alias pwgen=motus

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

if [[ "$OSTYPE" == "darwin"* ]]; then
	alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'
fi

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
