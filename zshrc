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
alias gf="$_git fetch"
alias gc="$_git commit"
alias gca="$_git commit --amend"
alias gcan="$_git commit --amend --no-edit"
alias gco="$_git checkout"
alias gcl="$_git checkout --theirs"  # Use local file
alias gcr="$_git checkout --ours"    # Use remote file
alias gd="$_git diff"
alias gl=tig
alias gcp="$_git cherry-pick"
alias gcpc="$_git cherry-pick --continue"
alias gp="$_git push"
alias gin="$_git submodule update --init --recursive"
alias gup="$_git submodule update --init --remote --recursive"
alias gundo="$_git reset HEAD^ --"
alias ga="$_git add"
alias gr="$_git rebase"
alias grc="$_git rebase --continue"

alias grep="echo Run: rg"  # ripgrep
alias find="echo Run: fd"

alias p=mpv
#alias ls=exa
alias ll="ls -l"
alias lt="tree"
alias loc="tokei -f --sort=lines"

alias instructor=$HOME/dev/instructor/instructor
alias seed="$HOME/dev/seed/seed --tmpfs"
alias bloop="echo Run: b"
alias b=$HOME/.bloop/bloop

alias pmk="python -m venv venv"
alias pld="source venv/bin/activate"
alias http="python3 -m http.server"

alias e=/usr/bin/nvim
alias cd="echo redundant"
alias ez="/usr/bin/nvim $HOME/.zshrc && source $HOME/.zshrc"
alias eg=/usr/bin/nvim-qt
alias vi="echo 'Run: e|eg'"
alias vim="echo 'Run: e|eg'"
alias nvim="echo 'Run: e|eg'"
alias nvim-qt="echo 'Run: eg'"

grb() { g show $1:$2 > $2 }

alias .=source
alias '?'="""
echo 'Aliases:
.    source
g    git
gst  git status
gsh  git show
gf   git fetch
gc   git commit
gca  git commit --amend
gcan git commit --amend --no-edit
gco  git checkout
gcl  git checkout --theirs  # Use local file
gcr  git checkout --ours    # Use remote file
gd   git diff
gl   tig
gcp  git cherry-pick
gcpc git cherry-pick --continue
gp   git push
gin  git submodule update --init --recursive
gup  git submodule update --init --remote --recursive
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
eg   nvim-qt
ez   nvim $HOME/.zshrc && source $HOME/.zshrc
pmk  python -m venv venv
pld  source venv/bin/activate
http python3 -m http.server'
"""

source ~/dotfiles/auto-ls.zsh
source ~/dotfiles/zjump.zsh
source ~/.profile
