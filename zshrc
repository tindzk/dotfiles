# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000

# Enter directories without `cd` command
setopt autocd

# Allow comments in commands using hashtag
setopt interactivecomments

# Spelling corrections
setopt correctall

# Disable beeping
unsetopt beep

# Enable case-insensitive globbing
unsetopt CASE_GLOB

# Completions
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
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

background() { "$@" & }

# Aliases
alias e='background nvim-qt'
alias g=git
alias p=mpv
alias ls="ls --color=auto"

alias instructor=$HOME/dev/instructor/instructor

alias venv-mk="python -m venv venv"
alias venv-ld="source venv/bin/activate"
alias http="python3 -m http.server"

source ~/.profile
