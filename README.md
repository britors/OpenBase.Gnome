# OpenBase Dark — GNOME Theme

Dark GNOME theme inspired by the OpenBase color palette — deep navy backgrounds with purple-to-pink accent gradients.

## Color Palette

| Role | Color |
|---|---|
| Background | `#0d0f1a` / `#131629` |
| Panel / Headerbar | `#080a12` |
| Surface | `#1a1c2e` / `#1e2040` |
| Purple accent | `#b44fff` |
| Pink accent | `#ff3fa4` |
| Purple light | `#c878ff` |
| Muted text | `#8888aa` |

## What's included

| File | Purpose |
|---|---|
| `OpenBase-Dark/gtk-3.0/gtk.css` | GTK3 theme (legacy apps) |
| `OpenBase-Dark/gtk-4.0/gtk.css` | GTK4 / libadwaita color overrides |
| `OpenBase-Dark/gnome-shell/gnome-shell.css` | GNOME Shell (panel, overview, notifications) |
| `OpenBase-Dark/index.theme` | Theme metadata |

## Installation

```bash
./install.sh
```

The script:
1. Copies the GTK3 theme to `~/.themes/OpenBase-Dark/`
2. Copies GTK4 overrides to `~/.config/gtk-4.0/`
3. Copies the theme to `~/.local/share/themes/` for GNOME Tweaks
4. Applies the GTK theme and dark color scheme via `gsettings`

## Applying the GNOME Shell theme

The shell theme requires the **User Themes** GNOME extension:

```bash
# Enable User Themes extension
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com

# Apply the shell theme
gsettings set org.gnome.shell.extensions.user-theme name 'OpenBase-Dark'
```

Or via **GNOME Tweaks** → Appearance → Shell → OpenBase Dark.

## Uninstall

```bash
./uninstall.sh
```

## Requirements

- GNOME 45 or later (optimized for GNOME 50)
- GTK 3.24+ / GTK 4.x
- [User Themes](https://extensions.gnome.org/extension/19/user-themes/) extension (for shell theme only)

## License

[MIT](LICENSE)
