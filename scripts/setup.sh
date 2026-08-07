#!/bin/bash

# MacBook Pro Complete Setup: Terminal + Languages + Apps
# Run this script to get your complete development environment

set -e

gold=$(tput setaf 3); green=$(tput setaf 2); red=$(tput setaf 1); dim=$(tput dim); reset=$(tput sgr0); bold=$(tput bold)
phase() { printf "\n%s%s%s\n" "$bold$gold" "$1" "$reset"; }
ok() { printf "%s✓%s %s\n" "$green" "$reset" "$1"; }
warn() { printf "%s⚠%s %s\n" "$gold" "$reset" "$1"; }
info() { printf "%s%s%s\n" "$dim" "$1" "$reset"; }

# EDIT THIS: Your GitHub username for dotfiles repo
GITHUB_USERNAME="zum281"

phase "Starting Setup"

phase "Terminal Environment"

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  info "Adding Homebrew to PATH..."
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  ok "Homebrew already installed"
fi

info "Installing font and essential applications..."
brew install --cask font-iosevka-term-slab-nerd-font
brew install --cask wezterm@nightly
brew install --cask raycast

info "Installing core CLI tools..."
brew install git gh neovim bat eza fzf ripgrep fd jq
brew install lazygit git-delta thefuck zoxide viu

info "Setting up dotfiles..."
mkdir -p ~/s/

# Clone dotfiles repo
if [ ! -d ~/s/dotfiles ]; then
  info "Cloning dotfiles repo..."
  git clone https://github.com/${GITHUB_USERNAME}/dotfiles.git ~/s/dotfiles
  ok "Dotfiles cloned to ~/s/dotfiles"
else
  ok "Dotfiles already exist in ~/s/dotfiles"
fi

./dotfiles-symlink

# Register the ember bat theme so bat + delta pick it up (delta syntax-theme = ember)
info "Building bat theme cache..."
bat cache --build

info "Sourcing shell configuration..."
# Source the new shell configuration (only if it's our symlink)
if [ -f ~/.zprofile ] && [ -L ~/.zprofile ]; then
  source ~/.zprofile
  ok "Sourced ~/.zprofile"
elif [ -f ~/.zprofile ]; then
  warn "~/.zprofile exists but is not our symlink - skipping source"
else
  warn "~/.zprofile not found - will be available after shell restart"
fi

ok "Terminal setup complete!"

phase "Programming Languages & Runtimes"

info "Installing Volta..."
if ! command -v volta &>/dev/null; then
  curl https://get.volta.sh | bash
  # Add volta to PATH for this session
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"

  # Verify Volta is accessible
  if command -v volta &>/dev/null; then
    ok "Volta installed and available"
    info "Getting started: volta install node@lts && volta install npm@latest"
  else
    warn "Volta installed but not in current PATH. You'll need to restart shell to use it."
  fi
else
  ok "Volta already installed"
fi

info "Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  info "Starting Xcode Command Line Tools installation..."
  info "A popup will appear - please click 'Install' and wait for completion."
  info "The rest of the script will continue while this installs in the background."
  xcode-select --install
  info "This provides the C compiler and development tools."
else
  ok "Xcode Command Line Tools already installed"
fi

ok "Phase 2 Complete!"

phase "Essential Applications"

info "Installing browsers and GUI applications..."
brew install --cask brave-browser
brew install --cask signal
brew install --cask vlc

phase "Setup complete!"

printf "%sMANUAL STEPS NEEDED:%s\n" "$bold$gold" "$reset"
echo "1. Set keyboard layout to International English (System Settings > Keyboard)"
echo "2. Remap CAPS LOCK → ESC (System Settings > Keyboard > Modifier Keys)"
echo "3. Run: gh auth login"
echo "4. Start new shell for full setup: exec zsh"
echo "5. Install Node.js: volta install node@lts"
echo ""
info "If any programming language tools seem missing after step 4, they should be available."
info "If not, the installation completed but PATH wasn't updated - exec zsh should fix it."
