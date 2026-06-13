#!/bin/bash
# Detectar la ruta donde está guardado este script
THEME_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
IMAGES_DIR=$THEME_DIR/contents/splash/images
PREVIEWS_DIR=$THEME_DIR/contents/previews

WALLPAPER=$(grep "Image=" ~/.config/plasma-org.kde.plasma.desktop-appletsrc | head -n 1 | cut -d "=" -f2 | sed "s|file://||")

if [ -f "$WALLPAPER" ]; then
    magick "$WALLPAPER" -blur 0x8 -fill black -colorize 40% "$IMAGES_DIR/bg_low.jpg"
    cp "$IMAGES_DIR/bg_low.jpg" "$PREVIEWS_DIR/preview.png"
    cp "$IMAGES_DIR/bg_low.jpg" "$PREVIEWS_DIR/splash.png"
fi
