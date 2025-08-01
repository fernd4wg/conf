#!/bin/bash

COMMAND_NAME="conf"
INSTALL_PATH="/usr/bin/$COMMAND_NAME"

# Ensure the user is root or using sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./install.sh)"
  exit 1
fi

# Copy the script to /usr/bin
cp "$COMMAND_NAME" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo "Installed $COMMAND_NAME to $INSTALL_PATH"
