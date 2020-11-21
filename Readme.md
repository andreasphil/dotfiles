# Dotfiles

A collection of configurations, installation scripts and handy tools I use on my Mac:

* ZSH
* Packages through [Homebrew](https://brew.sh), [Brew Bundle](https://github.com/Homebrew/homebrew-bundle) and `npm`
* Other software installed via [Cask](https://github.com/Homebrew/homebrew-cask)
* Terminal theme based [ayu-iTerm](https://github.com/hwyncho/ayu-iTerm)

## Setup

1. `setup/initialize` prompts you to enter the path where this repository is located on your machine and softlinks the configuration files to your home directory based on that
2. `setup/install` has functions for installing CLI tools and applications 

## Useful commands

* Re-create Brewfile from currently installed packages: `brew bundle dump [--force]`
* Reset installed Homebrew packages to Brewfile: `brew bundle cleanup`
* Create a "Codefile" from currently installed VS Code extensions `code --list-extensions > install/Codefile`
