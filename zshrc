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

PROMPT="%{$fg_bold[blue]%}%~ $%{$reset_color%} "

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
function gpo() { $_git push --set-upstream $(git remote | head -n1) $($_git rev-parse --abbrev-ref HEAD) }
alias gpf="$_git push --force-with-lease"
alias gsl="$_git submodule update --init --recursive"
alias gsr="$_git submodule update --init --remote --recursive"
alias gundo="$_git reset HEAD^ --"
alias ga="$_git add"
alias gr="$_git rebase"
alias grc="$_git rebase --continue"

alias p=mpv
alias ls=exa
alias ll="exa --long --git"
alias lt="exa --tree"
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
  [ ! -d "venv/" ] && python -m venv venv
  source venv/bin/activate
}

# Create and load virtual Python 2 environment
function penv2 {
  [ ! -d "venv/" ] && virtualenv2 venv
  source venv/bin/activate
}

alias http="python3 -m http.server"

alias e=/usr/bin/nvim
alias ez="/usr/bin/nvim $HOME/.zshrc && source $HOME/.zshrc"
alias eg=/usr/bin/neovide

grb() { g show $1:$2 > $2 }

pgweb() {
  pgweb_linux_amd64 --user=postgres --listen=8085 --db=$1
}

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
ls   exa
ll   exa --long --git
lt   exa --tree
loc  tokei -f --sort=lines
b    bloop
e    nvim
eg   neovide
ez   nvim $HOME/.zshrc && source $HOME/.zshrc
yt   youtube-dl --all-subs
yta  youtube-dl -f bestaudio
ytb  youtube-dl --all-subs --batch-file=<file>
yts  youtube-dl --write-auto-sub --sub-lang <lang> <url>
ytp  youtube-dl https://www.youtube.com/playlist?list=<id>
penv  python -m venv venv; venv/bin/activate
penv2 virtualenv2 venv; venv/bin/activate
pld   source venv/bin/activate
http  python3 -m http.server'
"""

source /usr/share/fzf/key-bindings.zsh
source ~/dotfiles/auto-ls.zsh
source ~/dotfiles/zjump.zsh
source ~/.profile
