# -----------------------------------------------------------------------------
# BASH PROFILE
#
# Andreas Philippi
# https://github.com/anphil
# If you find something useful, do whatever you want with it!
# -----------------------------------------------------------------------------

. "${HOME}/.local_dotfiles"
export PGDATA="${HOME}/.psql/data"

# -----------------------------------------------------------------------------
# Variables for colorful console output.
# Adapted from: http://unix.stackexchange.com/a/124408
# -----------------------------------------------------------------------------

# Regular
export C_BLK='\033[0;30m'  # Black
export C_RED='\033[0;31m'  # Red
export C_GRN='\033[0;32m'  # Green
export C_YLW='\033[0;33m'  # Yellow
export C_BLU='\033[0;34m'  # Blue
export C_PUR='\033[0;35m'  # Purple
export C_CYN='\033[0;36m'  # Cyan
export C_WHT='\033[0;37m'  # White

# Bold
export C_BBL='\033[1;30m' # Black
export C_BRE='\033[1;31m' # Red
export C_BGR='\033[1;32m' # Green
export C_BYL='\033[1;33m' # Yellow
export C_BBL='\033[1;34m' # Blue
export C_BPU='\033[1;35m' # Purple
export C_BCY='\033[1;36m' # Cyan
export C_BWH='\033[1;37m' # White

# Reset
export C_RST='\033[0m'

# -----------------------------------------------------------------------------
# Install git completion
# -----------------------------------------------------------------------------

source "${DOTFILES_ROOT}/git/git-completion.bash"

# -----------------------------------------------------------------------------
# Install rbenv
# -----------------------------------------------------------------------------

eval "$(rbenv init -)"

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------

# PATH split up to easier to read and manage. Built up reversely, i.e. the
# first segment will be the last in the final path. That allows us to keep
# the original path, but give priority to custom locations.
PATH="${PATH}:."
PATH="./node_modules/.bin:${PATH}"
PATH="${DOTFILES_ROOT}/bin:${PATH}"

export PATH

# -----------------------------------------------------------------------------
# Alias laziness
# -----------------------------------------------------------------------------

# Spare me three characters when going up one level
alias ..="cd .."

# Override ls to be colorful and show only one item per line
alias ls="ls -G1"

# Shorthand for detailed ls output
alias ll="ls -l"

# Shorthands for actions for the bookmarks script
alias b=". bookmarks"
alias bl="bookmarks list"
alias bc="bookmarks create"
alias bd="bookmarks delete"

# Shorthand to open the current directiory in finder
alias o="open ."

# Shorthand for running bin/rails
alias r="bin/rails"

# Shorthand for running Chrome with remote debugging enabled
alias chrome-debug="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222"
alias chrome-unsafe="chrome-debug --disable-web-security --user-data-dir=/Users/andreas.philippi/Downloads/TempUserData"

# Shorthands for various timers
alias pom="timer 1500 'Session finished!' 'Pomodoro' && timer 300 'Break finished!' 'Pomorodo'"
alias blacktea="timer 180 'Teatime!'"
alias herbtea="timer 480 'Teatime!'"

# -----------------------------------------------------------------------------
# Functions – everything too much for an alias and to little for a script
# -----------------------------------------------------------------------------

# Creates an executable file in the current directory
function new-script {
  touch "$1" && chmod +x "$1" && echo "#!/bin/bash" > "$1"
}

# Creates a new directory and cd into it
function cdnew {
  mkdir "$1" && cd "$1"
}

# Strips the argument of any file:// prefix and opens the remaining path inR
# VS Code.
function code-file {
  code "${1/file:\/\//}"
}

# -----------------------------------------------------------------------------
# Prompt configuration
# -----------------------------------------------------------------------------

# Awkwardly formatting NPM package info and Git branch name. But this way,
# we avoid unnecessary spaces between the previous and following prompt
# segments in case we're not in a package, a repository or neither of both.

# Reads name and version of the NPM package (in case we're in one). Requires
# node to be installed (obviously).
function get-npm-package-info {
  node -e "var pack=require('./package.json');
  console.log(pack.name + ' ' + pack.version);" 2> /dev/null
}

# Puts brackets around the package name if not empty.
function parse-npm-package-info {
  get-npm-package-info | sed -e "s/\(.*\)/ (\1)/"
}

# Reads the current Git branch name and wraps it in brackets (if not empty)
function parse-git-branch-name {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Determines whether
function git-changed {
  changedLines=$(git status -s 2> /dev/null | wc -l)
  if [[ $changedLines -gt 0 ]]
  then
    echo " has changes"
  fi
}

# Wrap prompt creation in a function to make it easier to read and manage
function get-prompt {
  # Host name + working directory
  p="\u@\h:\W"

  # NPM package name
  p="${p}\[${C_BLU}\]\$(parse-npm-package-info)\[${C_RST}\]"

  # Git branch name
  p="${p}\[${C_GRN}\]\$(parse-git-branch-name)\[${C_RST}\]"

  # Git branch status
  p="${p}\[${C_RED}\]\$(git-changed)\[${C_RST}\]"

  # username + $
  p="${p} → "

  echo "$p"
}

export PS1="$(get-prompt)"

# -----------------------------------------------------------------------------
# Say hello. Prints a colorful cow saying words of wisdom. Requires fortune,
# cowsay and lolcat to be installed:
#
# `brew install fortune cowsay
# gem install lolcat`
# -----------------------------------------------------------------------------

fortune|cowsay|lolcat
echo ""
