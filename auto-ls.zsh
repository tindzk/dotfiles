# vim: sw=2 ts=2 et!
# Source: https://github.com/desyncr/auto-ls
# set up default functions
if [[ $#AUTO_LS_COMMANDS -eq 0 ]]; then
  AUTO_LS_COMMANDS=(ls)
fi

auto-ls-ls () {
  ls
  [[ $AUTO_LS_NEWLINE != false ]] && echo ""
}

auto-ls () {
  if [[ $#BUFFER -eq 0 ]]; then
    zle && echo ""
    for cmd in $AUTO_LS_COMMANDS; do
      # If we detect a command with full path, ex: /bin/ls execute it
      if [[ $AUTO_LS_PATH != false && $cmd =~ '/' ]]; then
        eval $cmd
      else
        # Otherwise run auto-ls function
        auto-ls-$cmd
      fi
    done
    zle && zle redisplay
  else
    zle .$WIDGET
  fi
}

zle -N auto-ls
zle -N accept-line auto-ls

if [[ ${chpwd_functions[(I)auto-ls]} -eq 0 ]]; then
  chpwd_functions+=(auto-ls)
fi
