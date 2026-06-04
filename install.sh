#!/bin/bash
# Claude Usage Barometer installer
set -euo pipefail

REPO="taka-avantgarde/claude-usage-barometer"
RAW="https://raw.githubusercontent.com/$REPO/main/claude-usage.60s.sh"

echo "▶ Checking dependencies..."
command -v jq >/dev/null 2>&1 || brew install jq
[ -d "/Applications/SwiftBar.app" ] || brew install --cask swiftbar

# Use SwiftBar's configured plugin folder, or default to ~/SwiftBar
PLUGIN_DIR=$(defaults read com.ameba.SwiftBar PluginDirectory 2>/dev/null || echo "$HOME/SwiftBar")
[ -z "$PLUGIN_DIR" ] && PLUGIN_DIR="$HOME/SwiftBar"
defaults write com.ameba.SwiftBar PluginDirectory "$PLUGIN_DIR" >/dev/null 2>&1 || true
mkdir -p "$PLUGIN_DIR"

echo "▶ Downloading plugin..."
curl -fsSL "$RAW" -o "$PLUGIN_DIR/claude-usage.60s.sh"
chmod +x "$PLUGIN_DIR/claude-usage.60s.sh"

echo "▶ Restarting SwiftBar..."
osascript -e 'quit app "SwiftBar"' 2>/dev/null || true
sleep 1
open -a SwiftBar

echo "✅ Installed to $PLUGIN_DIR/claude-usage.60s.sh"
echo "   (First run may ask for Keychain access — choose 'Always Allow'.)"
