#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/assets/images/photos"
THUMB_DIR="$SOURCE_DIR/thumbnails"
MAX_SIZE="${THUMB_MAX_SIZE:-960}"
QUALITY="${THUMB_QUALITY:-82}"

mkdir -p "$THUMB_DIR"

generate_with_magick() {
  local src="$1"
  local dest="$2"

  magick "$src" \
    -auto-orient \
    -strip \
    -resize "${MAX_SIZE}x${MAX_SIZE}>" \
    -interlace Plane \
    -quality "$QUALITY" \
    "$dest"
}

generate_with_convert() {
  local src="$1"
  local dest="$2"

  convert "$src" \
    -auto-orient \
    -strip \
    -resize "${MAX_SIZE}x${MAX_SIZE}>" \
    -interlace Plane \
    -quality "$QUALITY" \
    "$dest"
}

generate_with_sips() {
  local src="$1"
  local dest="$2"

  sips -Z "$MAX_SIZE" "$src" --out "$dest" >/dev/null
}

generate_thumbnail() {
  local src="$1"
  local dest="$2"

  if command -v magick >/dev/null 2>&1; then
    generate_with_magick "$src" "$dest"
    return
  fi

  if command -v convert >/dev/null 2>&1; then
    generate_with_convert "$src" "$dest"
    return
  fi

  if command -v sips >/dev/null 2>&1; then
    generate_with_sips "$src" "$dest"
    return
  fi

  echo "No supported image tool found. Install ImageMagick or sips." >&2
  exit 1
}

shopt -s nullglob
patterns=(
  "$SOURCE_DIR"/*.jpg
  "$SOURCE_DIR"/*.jpeg
  "$SOURCE_DIR"/*.png
  "$SOURCE_DIR"/*.webp
  "$SOURCE_DIR"/*.JPG
  "$SOURCE_DIR"/*.JPEG
  "$SOURCE_DIR"/*.PNG
  "$SOURCE_DIR"/*.WEBP
)

count=0

for src in "${patterns[@]}"; do
  [ -f "$src" ] || continue

  dest="$THUMB_DIR/$(basename "$src")"
  generate_thumbnail "$src" "$dest"
  count=$((count + 1))
done

for thumb in "$THUMB_DIR"/*; do
  [ -f "$thumb" ] || continue

  src="$SOURCE_DIR/$(basename "$thumb")"
  if [ ! -f "$src" ]; then
    rm -f "$thumb"
  fi
done

echo "Generated $count thumbnail(s) in $THUMB_DIR"
