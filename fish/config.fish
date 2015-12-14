fish_vi_mode
alias ls='ls --color=auto'

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

alias e vi
alias g git
alias p mpv
