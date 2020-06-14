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

# fzf ayu
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#   --color=fg:#cbccc6,hl:#bae67e
#   --color=fg+:#ffffff,bg+:#1f2430,hl+:#bae67e
#   --color=info:#686868,prompt:#73d0ff,pointer:#ffd580
#   --color=marker:#f28779,spinner:#686868,header:#ffffff'

# fzf material
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#959dcb,bg:-1,hl:#c3e88d
  --color=fg+:#d0d0d0,bg+:#292d3e,hl+:#c3e88d
  --color=info:#607c8b,prompt:#c792ea,pointer:#ffcb6b
  --color=marker:#f07178,spinner:#607c8b,header:#82aaff'

# aliases
alias ..="cd .."
alias b=". bookmark"
alias ll="ls -l"
alias ls="ls -1"
alias myip="ipconfig getifaddr en0"
alias o="open ."
alias safari="open /Applications/Safari.app"

# Prepent current folder to path
PATH=".:${PATH}"
export PATH

