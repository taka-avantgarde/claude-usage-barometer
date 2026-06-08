#!/bin/bash
#
# Claude Usage Barometer — one-line installer
#   curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
#
# License: MIT
#
set -e
REPO="taka-avantgarde/claude-usage-barometer"
PLUGIN="claude-usage.60s.sh"
DIR="$HOME/SwiftBar"

echo "▶  Claude Usage Barometer — installer"

if ! command -v brew >/dev/null 2>&1; then
  echo "✋ Homebrew not found. Install it from https://brew.sh and re-run this."
  exit 1
fi

command -v jq >/dev/null 2>&1 || { echo "→ installing jq…"; brew install jq; }

if [ ! -d "/Applications/SwiftBar.app" ] && [ ! -d "$HOME/Applications/SwiftBar.app" ]; then
  echo "→ installing SwiftBar…"; brew install --cask swiftbar
fi

echo "→ installing plugin into $DIR …"
mkdir -p "$DIR"
curl -fsSL "https://raw.githubusercontent.com/$REPO/main/$PLUGIN" -o "$DIR/$PLUGIN"
chmod +x "$DIR/$PLUGIN"

# Best effort: point SwiftBar at the folder and launch it
defaults write com.ameba.SwiftBar PluginDirectory "$DIR" >/dev/null 2>&1 || true
open -a SwiftBar >/dev/null 2>&1 || open "/Applications/SwiftBar.app" >/dev/null 2>&1 || true

cat <<DONE

✅ Done! Check your menu bar.

  • If macOS asks to access "Claude Code-credentials"  → click Always Allow
  • If SwiftBar asks for a plugin folder              → choose:  $DIR
  • Nothing showing?  Click the SwiftBar icon → Refresh All

Prerequisite: you must be signed in to Claude Code on this Mac.
DONE
