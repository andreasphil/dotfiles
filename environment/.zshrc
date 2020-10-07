# -----------------------------------------------------------------------------
# ZSH CONFIG
# -----------------------------------------------------------------------------

. "${HOME}/.local_dotfiles"

# Oh my ZSH settings
export ZSH="${HOME}/.oh-my-zsh"
DISABLE_AUTO_TITLE="true"
ZSH_THEME="frisk" # other good ones are: frisk norm theunraveler
plugins=(git npm gem zsh-completions zsh-syntax-highlighting)
autoload -U compinit && compinit
autoload -U add-zsh-hook

source $ZSH/oh-my-zsh.sh

# postgres
export PGDATA="${HOME}/.psql/data"

# rbenv
eval "$(rbenv init -)"

# pyenv
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"

loadnvmrc() {
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

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

add-zsh-hook chpwd loadnvmrc
loadnvmrc

# aliases
alias ..="cd .."
alias b=". bookmark"
alias ll="ls -l"
alias ls="ls -1"
alias myip="ipconfig getifaddr en0"
alias o="open ."
alias safari="open /Applications/Safari.app"

# path
PATH="./node_modules/.bin:${PATH}"
PATH="${DOTFILES_ROOT}/bin:${PATH}"
PATH=".:${PATH}"
export PATH

