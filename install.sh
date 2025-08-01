#!/bin/bash

COMMAND_NAME="conf"
INSTALL_PATH="/usr/bin/$COMMAND_NAME"

# Ensure the user is root or using sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./install.sh)"
  exit 1
fi

if ! command -v nvim &>/dev/null; then
  echo "Neovim (nvim) is not installed."

  # Ask user for permission to install
  read -p "Do you want to install Neovim now? (y/n): " yn
  case $yn in
  [Yy]*)
    # Try to detect the OS and install accordingly
    if command -v apt &>/dev/null; then
      apt update
      apt install -y neovim
    elif command -v pacman &>/dev/null; then
      pacman -Sy neovim --noconfirm
    elif command -v dnf &>/dev/null; then
      dnf install -y neovim
    elif command -v brew &>/dev/null; then
      brew install neovim
    else
      echo "Unsupported package manager. Please install Neovim manually."
      exit 1
    fi
    ;;
  *)
    echo "Neovim is required. Aborting install."
    exit 1
    ;;
  esac
else
  echo "Neovim is already installed."
fi

# Copy the script to /usr/bin
cp "$COMMAND_NAME" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo "Installed $COMMAND_NAME to $INSTALL_PATH"
