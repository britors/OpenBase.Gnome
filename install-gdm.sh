#!/usr/bin/env bash
# OpenBase Dark — GDM Theme Installer
# Dependências: glib2 (glib-compile-resources)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GDM_SRC="$SCRIPT_DIR/OpenBase-Dark/gnome-shell/gdm"
WALLPAPER_REPO="$SCRIPT_DIR/../OpenBase.Wallpaper"
SVG_NAME="openbase-nebula.svg"
GDM_RESOURCE="/usr/share/gnome-shell/gnome-shell-theme.gresource"
BACKUP="${GDM_RESOURCE}.bak"

# ── Verificar dependências ────────────────────────────────────────────────

if ! command -v glib-compile-resources &>/dev/null; then
  echo "Erro: glib-compile-resources não encontrado."
  echo "Instale com: sudo pacman -S glib2   (Arch)"
  echo "             sudo apt install libglib2.0-dev-bin  (Debian/Ubuntu)"
  exit 1
fi

# ── Obter wallpaper ───────────────────────────────────────────────────────

SVG_DEST="$GDM_SRC/$SVG_NAME"

if [ ! -f "$SVG_DEST" ]; then
  if [ -f "$WALLPAPER_REPO/$SVG_NAME" ]; then
    echo "Copiando wallpaper de $WALLPAPER_REPO..."
    cp "$WALLPAPER_REPO/$SVG_NAME" "$SVG_DEST"
    echo "  ✓ $SVG_NAME copiado"
  else
    echo "Erro: wallpaper '$SVG_NAME' não encontrado."
    echo "Coloque o arquivo em: $SVG_DEST"
    echo "Ou clone o repositório OpenBase.Wallpaper ao lado deste."
    exit 1
  fi
fi

# ── Compilar gresource ────────────────────────────────────────────────────

echo "Compilando tema GDM..."

BUILD_OUT="$GDM_SRC/gnome-shell-theme.gresource"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

cp "$GDM_SRC/gnome-shell-dark.css" "$TMP/"
cp "$GDM_SRC/gnome-shell.css" "$TMP/"
cp "$GDM_SRC/$SVG_NAME" "$TMP/"
cp "$GDM_SRC/gnome-shell-theme.gresource.xml" "$TMP/"

glib-compile-resources \
  --sourcedir="$TMP" \
  --target="$BUILD_OUT" \
  "$TMP/gnome-shell-theme.gresource.xml"

echo "  ✓ gresource compilado → $BUILD_OUT"

# ── Instalar (requer sudo) ────────────────────────────────────────────────

echo ""
echo "Para instalar, execute:"
echo "  sudo cp $GDM_RESOURCE ${GDM_RESOURCE}.bak  # backup (se ainda não tiver)"
echo "  sudo cp $BUILD_OUT $GDM_RESOURCE"
echo "  sudo systemctl restart gdm"
echo ""

read -r -p "Instalar agora? (requer sudo) [s/N] " REPLY
if [[ "$REPLY" =~ ^[sS]$ ]]; then
  if [ ! -f "$BACKUP" ]; then
    echo "  Backup: $GDM_RESOURCE → $BACKUP"
    sudo cp "$GDM_RESOURCE" "$BACKUP"
  fi
  sudo cp "$BUILD_OUT" "$GDM_RESOURCE"
  echo "  ✓ Tema GDM instalado em $GDM_RESOURCE"
  echo ""
  echo "Reinicie o GDM para aplicar:"
  echo "  sudo systemctl restart gdm"
fi
