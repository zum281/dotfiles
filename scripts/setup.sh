#!/bin/bash

# MacBook Pro Complete Setup: Terminal + Languages + Apps
# Run this script to get your complete development environment

set -e

# EDIT THIS: Your GitHub username for dotfiles repo
GITHUB_USERNAME="zum281"

echo "Starting Setup"
echo "======================================"

echo ""
echo "Terminal Environment"
echo "=========================================="

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "Adding Homebrew to PATH..."
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed"
fi

echo "Installing font and essential applications..."
brew install --cask font-iosevka-term-slab-nerd-font
brew install --cask wezterm@nightly
brew install --cask raycast

echo "Installing core CLI tools..."
brew install git gh neovim bat eza fzf ripgrep fd jq
brew install lazygit git-delta thefuck zoxide viu

echo "Setting up dotfiles..."
mkdir -p ~/s/

# Clone dotfiles repo
if [ ! -d ~/s/dotfiles ]; then
  echo "Cloning dotfiles repo..."
  git clone https://github.com/${GITHUB_USERNAME}/dotfiles.git ~/s/dotfiles
  echo "[SUCCESS] Dotfiles cloned to ~/s/dotfiles"
else
  echo "Dotfiles already exist in ~/s/dotfiles"
fi

./dotfiles-symlink

# Register the ember bat theme so bat + delta pick it up (delta syntax-theme = ember)
echo "Building bat theme cache..."
bat cache --build

echo "Sourcing shell configuration..."
# Source the new shell configuration (only if it's our symlink)
if [ -f ~/.zprofile ] && [ -L ~/.zprofile ]; then
  source ~/.zprofile
  echo "[SUCCESS] Sourced ~/.zprofile"
elif [ -f ~/.zprofile ]; then
  echo "[WARN]  ~/.zprofile exists but is not our symlink - skipping source"
else
  echo "[WARN]  ~/.zprofile not found - will be available after shell restart"
fi

echo ""
echo "[SUCCESS] Terminal setup complete!"
echo "===================="

echo ""
echo "Programming Languages & Runtimes"
echo "==============================================="

echo "Installing Volta..."
if ! command -v volta &>/dev/null; then
  curl https://get.volta.sh | bash
  # Add volta to PATH for this session
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"

  # Verify Volta is accessible
  if command -v volta &>/dev/null; then
    echo "[SUCCESS] Volta installed and available"
    echo "Getting started: volta install node@lts && volta install npm@latest"
  else
    echo "[WARN]  Volta installed but not in current PATH. You'll need to restart shell to use it."
  fi
else
  echo "Volta already installed"
fi

echo "Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  echo "Starting Xcode Command Line Tools installation..."
  echo "A popup will appear - please click 'Install' and wait for completion."
  echo "The rest of the script will continue while this installs in the background."
  xcode-select --install
  echo "This provides the C compiler and development tools."
else
  echo "[SUCCESS] Xcode Command Line Tools already installed"
fi

echo ""
echo "Phase 2 Complete!"
echo "======================"

echo ""
echo "Essential Applications"
echo "=================================="

echo "Installing browsers and GUI applications..."
brew install --cask brave-browser
brew install --cask signal
brew install --cask vlc

echo ""
echo "Setup complete!"
echo "===================="

echo "MANUAL STEPS NEEDED:"
echo "1. Set keyboard layout to International English (System Settings > Keyboard)"
echo "2. Remap CAPS LOCK → ESC (System Settings > Keyboard > Modifier Keys)"
echo "3. Run: gh auth login"
echo "4. Start new shell for full setup: exec zsh"
echo "5. Install Node.js: volta install node@lts"
echo ""
echo "If any programming language tools seem missing after step 4, they should be available."
echo "If not, the installation completed but PATH wasn't updated - exec zsh should fix it."
