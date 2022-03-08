# From https://github.com/DanielAtKrypton/viper-env/blob/a45a0d9bbb6101e4f1162586e53728df92dce301/viper-env.plugin.zsh#

# Colors based on:
# https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html#16-colors
export COLOR_BRIGHT_VIOLET='\u001b[35;1m'
export COLOR_NC='\033[0m' # No Color

function activate_env_execution() {
  local virtualenv_directory=$1
  local d=$2
  local relative_env_path=$3
  local full_virtualenv_directory=$d/$virtualenv_directory

  echo Activating virtual environment ${COLOR_BRIGHT_VIOLET}$relative_env_path${COLOR_NC}
  source $full_virtualenv_directory/bin/activate
}

function get_env_path() {
  echo "$(basename "$1")/$2"
}

function get_envs() {
  local output="$(ls (.*|*)/bin/pip(.x))" &> /dev/null
  local candidate_envs_found
  if [ $? -eq 0 ]; then
    candidate_envs_found=($output)
  else
    candidate_envs_found=()
  fi
  envs_found=()
  for env in "${candidate_envs_found[@]}"
  do
    local env_name="$(dirname $env)"
    ls $env_name/activate &> /dev/null
    if [ $? -eq 0 ]; then
      envs_found+=("$(dirname $env_name)")
    fi
  done
}

function activate_env() {
  local current_dir=$1
  get_envs
  # echo "Envs found: $envs_found"
  if [ ${#envs_found[@]} -gt 0 ]; then
    # Use first found only!
    local env_name="${envs_found[1]}"
    # local env_name="$(dirname "$(dirname $env_to_use)")"
    local relative_activating_env_path="$(get_env_path $current_dir $env_name)"
    activate_env_execution $env_name $current_dir $relative_activating_env_path
  fi
}

function automatically_activate_python_env() {
  local current_dir="$PWD"
  local env_var="$VIRTUAL_ENV"
  if [[ -z $env_var ]]; then
    activate_env $current_dir
  else
    parentdir="$(dirname $env_var)"
    if [[ $current_dir/ != $parentdir/* ]]; then
      local deactivating_relative_env_path="$(realpath --relative-to=$current_dir $env_var)"
      echo Deactivating virtual environment ${COLOR_BRIGHT_VIOLET}$deactivating_relative_env_path${COLOR_NC}...
      deactivate
      activate_env $current_dir
    fi
  fi
}

autoload -Uz add-zsh-hook

# for MacOS insted of precmd chpwd might work more appropriately.
add-zsh-hook precmd automatically_activate_python_env
