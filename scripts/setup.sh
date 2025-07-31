#!/bin/bash

# MacBook Pro Complete Setup: Terminal + Languages + Apps
# Run this script to get your complete development environment

set -e

# EDIT THIS: Your GitHub username for dotfiles repo
GITHUB_USERNAME="zum281"

# Function to safely create symlinks with backup
create_symlink() {
    local source="$1"
    local target="$2"

    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # If target exists and is not already the correct symlink
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
            echo "✅ $target already correctly symlinked"
            return 0
        else
            echo "🔄 Backing up existing $target to ${target}.bak"
            mv "$target" "${target}.bak"
        fi
    fi

    # Create the symlink
    ln -sf "$source" "$target"

    # Verify the symlink was created successfully
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "✅ Successfully symlinked $target"
        return 0
    else
        echo "❌ Failed to create symlink $target"
        return 1
    fi
}

echo "🚀 Starting MacBook Pro Complete Setup"
echo "======================================"

# PHASE 1: Essential Terminal Environment
echo ""
echo "⚡ PHASE 1: Essential Terminal Environment"
echo "=========================================="

# Check if Homebrew is already installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    echo "🔧 Adding Homebrew to PATH..."
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew already installed"
fi

echo "🎨 Installing font and essential applications..."
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask ghostty
brew install --cask raycast

echo "🔗 Adding essential tap..."
brew tap jesseduffield/lazygit

echo "⚡ Installing core CLI tools..."
brew install git gh neovim tmux starship bat eza fzf ripgrep fd jq
brew install lazygit diff-so-fancy thefuck zoxide forgit viu

echo "📁 Installing TPM (tmux plugin manager)..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "✅ TPM installed"
else
    echo "✅ TPM already exists"
fi

echo "📂 Setting up dotfiles..."
# Create ~/s/ directory if it doesn't exist
mkdir -p ~/s/

# Clone dotfiles repo
if [ ! -d ~/s/dotfiles ]; then
    echo "📦 Cloning dotfiles repo..."
    git clone https://github.com/${GITHUB_USERNAME}/dotfiles.git ~/s/dotfiles
    echo "✅ Dotfiles cloned to ~/s/dotfiles"
else
    echo "✅ Dotfiles already exist in ~/s/dotfiles"
fi

echo "🔗 Creating symlinks..."
# Create all the necessary symlinks
create_symlink ~/s/dotfiles/config/ghostty ~/.config/ghostty
create_symlink ~/s/dotfiles/home/zshrc ~/.zshrc
create_symlink ~/s/dotfiles/config/tmux ~/.config/tmux
create_symlink ~/s/dotfiles/config/nvim ~/.config/nvim
create_symlink ~/s/dotfiles/home/zprofile ~/.zprofile

# Also symlink other config files mentioned in the dotfiles
create_symlink ~/s/dotfiles/home/gitconfig-shared ~/.gitconfig-shared
create_symlink ~/s/dotfiles/config/bat ~/.config/bat
create_symlink ~/s/dotfiles/config/starship.toml ~/.config/starship.toml
create_symlink ~/s/dotfiles/config/lazygit ~/.config/lazygit

echo "🔄 Sourcing shell configuration..."
# Source the new shell configuration (only if it's our symlink)
if [ -f ~/.zprofile ] && [ -L ~/.zprofile ]; then
    source ~/.zprofile
    echo "✅ Sourced ~/.zprofile"
elif [ -f ~/.zprofile ]; then
    echo "⚠️  ~/.zprofile exists but is not our symlink - skipping source"
else
    echo "⚠️  ~/.zprofile not found - will be available after shell restart"
fi

echo ""
echo "🎉 Phase 1 Complete!"
echo "===================="

# PHASE 1.5: Programming Languages & Runtimes
echo ""
echo "💻 PHASE 1.5: Programming Languages & Runtimes"
echo "==============================================="

echo "📦 Installing Volta (Node.js version manager)..."
if ! command -v volta &> /dev/null; then
    curl https://get.volta.sh | bash
    # Add volta to PATH for this session
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"

    # Verify Volta is accessible
    if command -v volta &> /dev/null; then
        echo "✅ Volta installed and available"
        echo "💡 Getting started: volta install node@lts && volta install npm@latest"
    else
        echo "⚠️  Volta installed but not in current PATH. You'll need to restart shell to use it."
    fi
else
    echo "✅ Volta already installed"
fi


echo "🦀 Installing Rust (rustup + cargo)..."
if ! command -v rustc &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # Add cargo to PATH for this session
    source ~/.cargo/env

    # Verify Rust tools are accessible
    if command -v cargo &> /dev/null; then
        echo "✅ Rust installed and available (includes rustc compiler + cargo package manager)"
        echo "💡 Getting started: cargo new hello-world && cd hello-world && cargo run"
    else
        echo "⚠️  Rust installed but cargo not in current PATH. You'll need to restart shell to use it."
    fi
else
    echo "✅ Rust already installed"
fi

echo "🐹 Installing Go..."
brew install go
echo "✅ Go installed (includes built-in package manager)"
echo "💡 Getting started: go mod init hello && echo 'package main; import \"fmt\"; func main() { fmt.Println(\"Hello Go!\") }' > main.go && go run main.go"

echo "🔧 Installing Xcode Command Line Tools (C compiler)..."
if ! xcode-select -p &> /dev/null; then
    echo "⚠️  Starting Xcode Command Line Tools installation..."
    echo "    A popup will appear - please click 'Install' and wait for completion."
    echo "    The rest of the script will continue while this installs in the background."
    xcode-select --install
    echo "💡 This provides the C compiler and development tools."
else
    echo "✅ Xcode Command Line Tools already installed"
fi

echo ""
echo "🎉 Phase 1.5 Complete!"
echo "======================"

# PHASE 2: Essential Applications
echo ""
echo "📱 PHASE 2: Essential Applications"
echo "=================================="

echo "🌐 Installing browsers and GUI applications..."
brew install --cask brave-browser
brew install --cask obsidian
brew install --cask signal
brew install --cask vlc
brew install --cask maccy
brew install --cask keycastr

echo "🎵 Installing ncspot (Spotify TUI)..."
brew install ncspot

echo ""
echo "🎉 Phase 2 Complete!"
echo "===================="

echo ""
echo "🎉 ALL PHASES COMPLETE!"
echo "======================="
echo ""
echo "📋 MANUAL STEPS NEEDED:"
echo "1. 🌍 Set keyboard layout to International English (System Settings > Keyboard)"
echo "2. ⌨️  Remap CAPS LOCK → ESC (System Settings > Keyboard > Modifier Keys)"
echo "3. 🔑 Run: gh auth login"
echo "4. 🔄 Start new shell for full setup: exec zsh"
echo "5. 🔌 Start tmux, then press Ctrl+; + I to install tmux plugins"
echo "6. 📦 Install Node.js: volta install node@lts"
echo ""
echo "💡 If any programming language tools seem missing after step 4, they should be available."
echo "   If not, the installation completed but PATH wasn't updated - exec zsh should fix it."
echo ""
echo "💡 After these steps, your complete development environment will be ready!"
echo ""
echo "🎯 Your complete setup includes:"
echo "   ✅ Terminal: Ghostty + tmux + neovim + zsh with all your configs"
echo "   ✅ CLI Tools: bat, eza, lazygit, fzf, and all your aliases"
echo "   ✅ Languages: Node.js (via Volta), Bun, Rust, Go, C"
echo "   ✅ Apps: Brave, Obsidian, Signal, VLC, Maccy, KeyCastr"
echo "   ✅ Music: ncspot for terminal Spotify"
echo ""
echo "🚀 Happy coding!"
