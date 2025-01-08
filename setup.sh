#!/bin/bash

# Trap to handle script interruption
trap 'echo "Setup interrupted. Re-run the script to continue."; exit 1' SIGINT

echo "Starting macOS setup..."

# Function to install a CLI tool if not installed
install_cli() {
  if ! command -v "$1" &>/dev/null; then
    echo "Installing $1..."
    brew install "$1" || echo "Error installing $1. Skipping..."
  else
    echo "$1 is already installed."
  fi
}

# Function to install a cask app if not installed
install_cask() {
  if ! brew list --cask | grep -q "$1"; then
    echo "Installing $1..."
    brew install --cask "$1" || echo "Error installing $1. Skipping..."
  else
    echo "$1 is already installed."
  fi
}

# Ensure Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    echo "Homebrew installation failed. Exiting."
    exit 1
  }
else
  echo "Homebrew is already installed."
fi

# Install CLI tools
install_cli git
install_cli zsh
install_cli httpie
install_cli node
install_cli python
install_cli pyenv
install_cli nvm
install_cli android-platform-tools # ADB
install_cli mackup
install_cli k9s
install_cli k6
install_cli jmeter

# Install cask apps
install_cask docker
install_cask visual-studio-code
install_cask iterm2
install_cask proxyman
install_cask sublime-text
install_cask postman
install_cask android-studio
install_cask flutter
install_cask slack
install_cask google-chrome
install_cask opera
install_cask firefox
install_cask rectangle
install_cask dbeaver-community

# Install BasicTeX for LaTeX
if ! command -v pdflatex &>/dev/null; then
  echo "Installing BasicTeX (LaTeX CLI)..."
  brew install --cask basictex
  export PATH="/Library/TeX/texbin:$PATH"
  echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.zshrc
else
  echo "LaTeX is already installed: $(pdflatex --version | head -n 1)"
fi

# Verify LaTeX installation
if command -v pdflatex &>/dev/null; then
  echo "LaTeX installed successfully: $(pdflatex --version | head -n 1)"
else
  echo "Error: LaTeX is not installed."
fi

# Install SDKMAN
if [ ! -d "$HOME/.sdkman" ]; then
  echo "Installing SDKMAN..."
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
else
  echo "SDKMAN is already installed."
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Ensure SDKMAN works before installing Java and Gradle
if command -v sdk &>/dev/null; then
  sdk install java 17.0.8-tem || echo "Error installing Java."
  sdk install gradle || echo "Error installing Gradle."
else
  echo "Error: SDKMAN installation failed or sdk command not found."
fi

# Install automation and testing tools
npm install -g cypress playwright appium || echo "Error installing testing tools."

# Use pipx for Python tools
if ! command -v pipx &>/dev/null; then
  echo "Installing pipx for Python package management..."
  brew install pipx
  pipx ensurepath
fi

# Install Selenium with pipx
pipx install selenium || echo "Error installing Selenium with pipx."

# Install Oh My Zsh and plugins
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || echo "Error installing Oh My Zsh."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  echo "Installing Zsh autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing Zsh syntax highlighting plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# Add plugins to ~/.zshrc
if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
  echo "Adding plugins to Zsh configuration..."
  sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
fi

# macOS tweaks
echo "Applying macOS system preferences..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.dock tilesize -int 36
killall Finder
killall Dock

# Run post-installation tests
echo "Running post-installation tests..."
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

if npx cypress --version &>/dev/null; then
  echo "Cypress installed successfully: $(npx cypress --version)"
else
  echo "Error: Cypress is not installed."
fi

if brew list --cask | grep -q "dbeaver-community"; then
  echo "DBeaver installed successfully."
else
  echo "Error: DBeaver is not installed."
fi

echo "Setup complete! You can safely re-run this script to fix incomplete installations. Restart your terminal for changes to take effect."
