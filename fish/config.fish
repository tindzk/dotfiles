# Git
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_color_branch yellow
function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)

  set_color normal
  printf '%s ' (__fish_git_prompt)

  set_color normal
end

# Lua/Torch
set -x PATH $PATH $HOME/.luarocks/bin
set -x PATH $PATH $HOME/torch/install/bin
set -x LD_LIBRARY_PATH $HOME/torch/install/lib
set -x DYLD_LIBRARY_PATH $HOME/torch/install/lib

# cuDNN
set -x LD_LIBRARY_PATH $LD_LIBRARY_PATH:$HOME/cuda/lib64
set -x DYLD_LIBRARY_PATH $DYLD_LIBRARY_PATH:$HOME/cuda/lib64

# Java/Scala
set JAVA_OPTS $JAVA_OPTS "
  -Dscala.color
  -XX:InitialHeapSize=1024m
  -XX:MaxHeapSize=4096m
  -XX:+CMSClassUnloadingEnabled
"
set SBT_OPTS $JAVA_OPTS

# Vim
fish_vi_key_bindings
set EDITOR nvim

# Aliases
alias e vi
alias g git
alias p mpv
alias ls "ls --color=auto"
