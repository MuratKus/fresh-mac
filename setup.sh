#!/bin/bash

echo "Starting macOS setup..."

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi

# Install essential tools and apps via Homebrew
echo "Installing applications and tools via Homebrew..."
brew install git
brew install zsh
brew install httpie
brew install node
brew install python
brew install pyenv
brew install nvm
brew install android-platform-tools # ADB
brew install mackup

brew install --cask docker
brew install --cask visual-studio-code
brew install --cask iterm2
brew install --cask proxyman
brew install --cask postman
brew install --cask android-studio
brew install --cask flutter
brew install --cask slack
brew install --cask google-chrome
brew install --cask opera
brew install --cask firefox
brew install --cask rectangle # Window management

# Install programming tools
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Install Java and Gradle via SDKMAN
sdk install java 17.0.8-tem
sdk install gradle

# Install automation and testing tools
npm install -g cypress playwright appium
pip install selenium

# Install Zsh plugins
echo "Installing Oh My Zsh and plugins..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Add plugins to ~/.zshrc
if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
  echo "Adding plugins to Zsh configuration..."
  sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
fi

# macOS tweaks
echo "Applying macOS system preferences..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock autohide -bool true
killall Finder
killall Dock

# Run post-installation tests
echo "Running post-installation tests..."

# Test CLI tools
if command -v git &>/dev/null; then
  echo "Git installed successfully: $(git --version)"
else
  echo "Error: Git is not installed."
fi

if command -v node &>/dev/null; then
  echo "Node.js installed successfully: $(node --version)"
else
  echo "Error: Node.js is not installed."
fi

if command -v python3 &>/dev/null; then
  echo "Python installed successfully: $(python3 --version)"
else
  echo "Error: Python is not installed."
fi

if command -v brew &>/dev/null; then
  echo "Homebrew installed successfully."
else
  echo "Error: Homebrew is not installed."
fi

# Test GUI applications
if brew list --cask | grep -q "google-chrome"; then
  echo "Google Chrome installed successfully."
else
  echo "Error: Google Chrome is not installed."
fi

if brew list --cask | grep -q "slack"; then
  echo "Slack installed successfully."
else
  echo "Error: Slack is not installed."
fi

# Test testing tools
if npx cypress --version &>/dev/null; then
  echo "Cypress installed successfully: $(npx cypress --version)"
else
  echo "Error: Cypress is not installed."
fi

if npx playwright --version &>/dev/null; then
  echo "Playwright installed successfully: $(npx playwright --version)"
else
  echo "Error: Playwright is not installed."
fi

# Reminder to restore settings with Mackup
echo "Don't forget to restore your settings with Mackup!"
echo "Setup complete! Restart your terminal for all changes to take effect."
