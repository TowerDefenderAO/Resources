#!/usr/bin/env bash
# Baja los recursos de audio CC0 verificados, guarda la evidencia de licencia
# y calcula el checksum de cada original.
set -u

BASE="D:/Github/TowerDefender/Resources/Audio"
SRC="$BASE/Source"
LIC="$BASE/Licenses"
PAG="$BASE/_pages"
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0 Safari/537.36"

mkdir -p "$SRC" "$LIC" "$PAG"

# --- el texto legal de CC0, una sola vez -----------------------------------
if [ ! -s "$LIC/CC0-1.0-legalcode.txt" ]; then
  curl -sSL --max-time 60 -A "$UA" \
    "https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt" \
    -o "$LIC/CC0-1.0-legalcode.txt"
  echo "[lic] CC0 legalcode: $(wc -c < "$LIC/CC0-1.0-legalcode.txt") bytes"
fi

# baja_kenney <slug>
baja_kenney() {
  local slug="$1"
  local page="https://kenney.nl/assets/$slug"
  local html="$PAG/kenney-$slug.html"

  echo "=== kenney/$slug ==="
  curl -sSL --max-time 90 -A "$UA" "$page" -o "$html" || { echo "  !! falló la página"; return 1; }

  local zip
  zip=$(grep -oE "href='https://kenney\.nl/media/pages/assets/[^']*\.zip'" "$html" \
        | head -1 | sed "s/^href='//; s/'$//")
  if [ -z "$zip" ]; then echo "  !! no encontré el zip"; return 1; fi

  mkdir -p "$SRC/kenney-$slug" "$LIC/kenney-$slug"
  local out="$SRC/kenney-$slug/$(basename "$zip")"
  curl -sSL --max-time 300 -A "$UA" -e "$page" "$zip" -o "$out" || { echo "  !! falló el zip"; return 1; }

  cp "$html" "$LIC/kenney-$slug/page.html"
  echo "$page" > "$LIC/kenney-$slug/source.url"
  sha256sum "$out" | sed "s|$SRC/||" > "$LIC/kenney-$slug/sha256.txt"
  echo "  ok  $(basename "$out")  $(du -h "$out" | cut -f1)"
}

# baja_oga <slug> [regex-extra]
baja_oga() {
  local slug="$1"
  local page="https://opengameart.org/content/$slug"
  local html="$PAG/oga-$slug.html"

  echo "=== oga/$slug ==="
  curl -sSL --max-time 90 -A "$UA" "$page" -o "$html" || { echo "  !! falló la página"; return 1; }

  # los adjuntos reales, sin los previews que genera el sitio
  local files
  files=$(grep -oE 'href="https://opengameart\.org/sites/default/files/[^"]*\.(zip|wav|mp3|ogg|7z)"' "$html" \
          | sed 's/^href="//; s/"$//' | grep -v '/audio_preview/' | sort -u)
  if [ -z "$files" ]; then echo "  !! no encontré adjuntos"; return 1; fi

  mkdir -p "$SRC/oga-$slug" "$LIC/oga-$slug"
  local f out
  for f in $files; do
    out="$SRC/oga-$slug/$(basename "$f" | sed 's/%20/_/g')"
    if [ -s "$out" ]; then echo "  ya estaba $(basename "$out")"; continue; fi
    curl -sSL --max-time 300 -A "$UA" -e "$page" "$f" -o "$out" \
      && echo "  ok  $(basename "$out")  $(du -h "$out" | cut -f1)" \
      || echo "  !! falló $f"
  done

  cp "$html" "$LIC/oga-$slug/page.html"
  echo "$page" > "$LIC/oga-$slug/source.url"
  ( cd "$SRC/oga-$slug" && sha256sum ./* ) > "$LIC/oga-$slug/sha256.txt" 2>/dev/null
  # el campo de licencia, recortado de la propia página, como evidencia
  grep -oE 'publicdomain/zero/1\.0|licenses/by/[0-9.]+|licenses/by-sa/[0-9.]+|licenses/by-nc[^"]*' "$html" \
    | sort -u > "$LIC/oga-$slug/licencia-detectada.txt"
}

# ---------------------------------------------------------------- Kenney (CC0)
for s in interface-sounds ui-audio impact-sounds rpg-audio music-jingles; do
  baja_kenney "$s"
done

# ------------------------------------------------------------- OpenGameArt SFX
baja_oga rpg-sound-pack          # artisticdude, CC0, 95 wav
baja_oga 80-cc0-rpg-sfx          # rubberduck, CC0, 80 sfx

# ----------------------------------------------------------- OpenGameArt música
baja_oga medieval-exploration        # menú
baga=0
baja_oga medieval-the-old-tower-inn  # gameplay tranquilo (trae loop)
baja_oga medieval-market-day         # gameplay normal (trae loop)
baja_oga medieval-battle             # oleada intensa
baja_oga boss-battle-music           # boss
baja_oga medieval-victory-theme      # victoria
baja_oga medieval-defeat-theme       # derrota

echo
echo "=== TOTAL ==="
du -sh "$SRC" 2>/dev/null
