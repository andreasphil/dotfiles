# -----------------------------------------------------------------------------
# ZSH CONFIG
#
# Andreas Philippi
# https://github.com/andrsphil
# -----------------------------------------------------------------------------

. "${HOME}/.local_dotfiles"

PATH="${PATH}:."
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
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# aliases
alias ..="cd .."
alias b=". bookmarks"
alias ll="ls -l"
alias ls="ls -1"
alias myip="ipconfig getifaddr en0"
alias o="open ."
alias safari="open /Applications/Safari.app"

# say hello
fortune|cowsay|lolcat
echo ""
