# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000

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

function zle-line-init zle-keymap-select () {
  # See https://github.com/AguirreIF/urxvt-patchs/blob/master/README.md
  case $KEYMAP in
    vicmd)      print -n -- "\033[2 q";;  # block cursor (normal mode)
    viins|main) print -n -- "\033[6 q";;  # vertical cursor (insert mode)
  esac

  # Prompt
  PS1="%{$fg_bold[blue]%}${PWD/#$HOME/~} $%{$reset_color%} "
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export _git=/usr/bin/git
alias g=$_git
alias git="echo Run: g"
alias gst="$_git status"
alias gsh="$_git show"
alias gc="$_git commit"
alias gd="$_git diff"
alias gl="$_git log"
alias gp="$_git push"
alias gin="$_git submodule update --init --recursive"
alias gup="$_git submodule update --init --remote --recursive"
alias gundo="$_git reset HEAD^ --"
alias ga="$_git commit --amend"
alias gae="$_git commit --amend --no-edit"

alias p=mpv
alias ls="ls --color=auto"

alias instructor=$HOME/dev/instructor/instructor
alias seed="$HOME/dev/seed/seed --tmpfs"
alias bloop="echo Run: b"
alias b=$HOME/.bloop/bloop

alias pmk="python -m venv venv"
alias pld="source venv/bin/activate"
alias http="python3 -m http.server"

alias e=/usr/bin/nvim
alias ez="/usr/bin/nvim $HOME/.zshrc && source $HOME/.zshrc"
alias eg=/usr/bin/nvim-qt
alias vi="echo 'Run: e|eg'"
alias vim="echo 'Run: e|eg'"
alias nvim="echo 'Run: e|eg'"
alias nvim-qt="echo 'Run: eg'"

alias .=source

alias '?'="""
echo 'Aliases:
.    source
g    git
gst  git status
gsh  git show
gc   git commit
gd   git diff
gl   git log
gp   git push
gin  git submodule update --init --recursive
gup  git submodule update --init --remote --recursive
gun  git reset HEAD^ --
ga   git commit --amend
gae  git commit --amend --no-edit
p    mpv
b    bloop
e    nvim
eg   nvim-qt
ez   nvim $HOME/.zshrc && source $HOME/.zshrc
pmk  python -m venv venv
pld  source venv/bin/activate
http python3 -m http.server'
"""

source ~/.profile
