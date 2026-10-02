#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
installdir="$HOME/start-menu"

echo "Installing start-menu..."

# Check if already installed
if [ -L /usr/local/bin/start-menu ]; then
    echo "start-menu is already installed. Updating..."
    sudo rm -f /usr/local/bin/start-menu
fi

# Create symlink
sudo ln -s "$installdir/start-menu.sh" /usr/local/bin/start-menu
echo "start-menu installed. Run 'start-menu' to start."

