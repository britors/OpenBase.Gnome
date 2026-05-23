#!/usr/bin/env bash
# OpenBase Dark — GNOME Theme Installer

set -e

THEME_NAME="OpenBase-Dark"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_SRC="$SCRIPT_DIR/$THEME_NAME"

THEMES_DIR="$HOME/.themes"
GTK4_DIR="$HOME/.config/gtk-4.0"
SHELL_DIR="$HOME/.local/share/themes"

echo "Installing OpenBase Dark theme..."

# GTK2/GTK3 — standard themes folder
mkdir -p "$THEMES_DIR"
rm -rf "$THEMES_DIR/$THEME_NAME"
cp -r "$THEME_SRC" "$THEMES_DIR/$THEME_NAME"
echo "  ✓ GTK3 theme → $THEMES_DIR/$THEME_NAME"

# GTK4 / libadwaita — user config override
mkdir -p "$GTK4_DIR"
cp "$THEME_SRC/gtk-4.0/gtk.css" "$GTK4_DIR/gtk.css"
cp "$THEME_SRC/gtk-4.0/gtk-dark.css" "$GTK4_DIR/gtk-dark.css"
echo "  ✓ GTK4 overrides → $GTK4_DIR"

# Also install to local themes for GNOME Shell / Tweaks
mkdir -p "$SHELL_DIR"
rm -rf "$SHELL_DIR/$THEME_NAME"
cp -r "$THEME_SRC" "$SHELL_DIR/$THEME_NAME"
echo "  ✓ GNOME Shell theme → $SHELL_DIR/$THEME_NAME"

# Apply GTK theme via gsettings
if command -v gsettings &>/dev/null; then
  gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
  echo "  ✓ GTK theme applied via gsettings"
fi

echo ""
echo "Done! To apply the GNOME Shell theme:"
echo "  1. Install GNOME Tweaks: sudo pacman -S gnome-tweaks"
echo "  2. Open Tweaks → Appearance → Shell → OpenBase Dark"
echo ""
echo "Or via extension User Themes:"
echo "  gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com"
echo "  gsettings set org.gnome.shell.extensions.user-theme name '$THEME_NAME'"
