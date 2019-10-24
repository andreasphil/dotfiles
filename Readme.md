# Dotfiles

A collection of configurations, installation scripts and handy tools I use on my Mac:

* ZSH
* Packages through [Homebrew](https://brew.sh), [Brew Bundle](https://github.com/Homebrew/homebrew-bundle), `gem` & `npm`
* Other software installed via [Cask](https://github.com/Homebrew/homebrew-cask)
* Terminal themes are based on [lysyi3m/macos-terminal-themes](https://github.com/lysyi3m/macos-terminal-themes)

## Setup

1. `install/_initialize` prompts you to enter the path where this repository is located on your machine and softlinks the configuration files to your home directory based on that.
2. `install/_install` downloads the Xcode command line tools, Homebrew and all the rest.
3. `install/_update` keeps everything up-to-date.

## Useful commands

* Re-create Brewfile from currently installed packages: `brew bundle dump [--force]`
* Reset installed Homebrew packages to Brewfile: `brew bundle cleanup`
* Create a "Codefile" from currently installed VS Code extensions `code --list-extensions > install/Codefile`
