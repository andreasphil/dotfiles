# -----------------------------------------------------------------------------
# ZSH CONFIG
#
# Andreas Philippi
# https://github.com/andrsphil
# -----------------------------------------------------------------------------

. "${HOME}/.local_dotfiles"

PATH="./node_modules/.bin:${PATH}"
PATH="${DOTFILES_ROOT}/bin:${PATH}"
export PATH

# Oh my ZSH settings
export ZSH="${HOME}/.oh-my-zsh"
DISABLE_AUTO_TITLE="true"

# Plugins
plugins=(git npm gem zsh-completions zsh-syntax-highlighting)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# Prompt
SPACESHIP_CHAR_SYMBOL="▲ "
SPACESHIP_CHAR_COLOR_SUCCESS=white
SPACESHIP_TIME_SHOW=true
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_BATTERY_THRESHOLD=30
autoload -U promptinit; promptinit
prompt spaceship

# -----------------------------------------------------------------------------
# User configuration
# -----------------------------------------------------------------------------

# postgres config
export PGDATA="${HOME}/.psql/data"

# rbenv
eval "$(rbenv init -)"

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# aliases
alias ..="cd .."
alias b=". bookmarks"
alias ll="ls -l"
alias ls="ls -1"
alias myip="ipconfig getifaddr en0"
alias o="open ."
alias safari="open /Applications/Safari.app"

# Prepent current folder to path
PATH=".:${PATH}"
export PATH

