#!/usr/bin/env bash
# OpenBase Dark — GNOME Theme Uninstaller

THEME_NAME="OpenBase-Dark"

echo "Removing OpenBase Dark theme..."

rm -rf "$HOME/.themes/$THEME_NAME"
rm -rf "$HOME/.local/share/themes/$THEME_NAME"
rm -f  "$HOME/.config/gtk-4.0/gtk.css"
rm -f  "$HOME/.config/gtk-4.0/gtk-dark.css"

if command -v gsettings &>/dev/null; then
  gsettings reset org.gnome.desktop.interface gtk-theme
  gsettings reset org.gnome.desktop.interface color-scheme
fi

echo "  ✓ Theme removed and defaults restored"
