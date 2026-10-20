# Dotfiles 👾

**Configurations and scripts I use on my Mac**

## Usage

```bash
# Softlink files to home directory and create placeholders for local configuration:
setup/init

# Install Homebrew and apps:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install --file setup/Brewfile

# Install global packages managed by mise:
mise install

# Configure macOS:
setup/preferences
```

Additionally:

- for Git: Either generate a new SSH key locally and add it to GitHub, or...
- configure Git to pull keys for SSH and signing from 1Password (snippet in 1Pw)
- import terminal profile and rectangle config from `setup/`
- install any additional applications from the App Store
