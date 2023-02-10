# Dotfiles

A collection of configurations, installation scripts and handy tools I use on my Mac.

## Setup

- `setup/init` to softlink configuration files to your home directory
- Install:
  - [ ] [Homebrew](https://brew.sh)
  - [ ] [Oh My ZSH](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
  - [ ] [ZSH Completions](https://github.com/zsh-users/zsh-completions#oh-my-zsh)
  - [ ] [ZSH Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

## Useful commands

```sh
# Install from Brewfile
brew bundle install

# Re-create Brewfile from currently installed packages:
brew bundle dump [--force]

# Reset installed Homebrew packages to Brewfile:
brew bundle cleanup
```
