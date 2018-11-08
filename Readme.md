# Dotfiles

The dotfiles I use to setup, customize and maintain my macOS installation. Includes installation scripts, bash profile, some configuration files and a few useful tools.

Almost all software I use is managed using [Homebrew](https://brew.sh) in combination with [Cask](https://github.com/Homebrew/homebrew-cask) and [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle), Gem or NPM.

# Useful commands

* Re-create Brewfile from currently installed packages: `brew bundle dump [--force]`
* Reset installed Homebrew packages to Brewfile: `brew bundle cleanup`
* Create a "Codefile" from currently installed VS Code extensions `code --list-extensions > install/Codefile`
