#!/bin/bash
# Move WhatsApp images into certificates/ and rename to certNN.jpeg
# Branch: organize/certificates

set -euo pipefail

files=(
"WhatsApp Image 2026-02-27 at 6.41.45 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.42.23 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.42.38 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.43.32 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.43.41 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.43.51 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.44.01 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.44.26 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.44.47 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.45.06 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.46.18 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.46.40 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.50.58 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.51.25 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.51.52 PM.jpeg"
"WhatsApp Image 2026-02-27 at 6.54.49 PM.jpeg"
"WhatsApp Image 2026-08-13 at 8.46.41 PM.jpeg"
"WhatsApp Image 2026-08-13 at 8.46.42 PM (2).jpeg"
"WhatsApp Image 2026-08-13 at 8.46.43 PM (1).jpeg"
"WhatsApp Image 2026-08-13 at 8.46.43 PM (2).jpeg"
"WhatsApp Image 2026-08-13 at 8.46.43 PM.jpeg"
"WhatsApp Image 2026-08-13 at 8.46.44 PM (1).jpeg"
"WhatsApp Image 2026-08-13 at 8.46.44 PM (2).jpeg"
"WhatsApp Image 2026-08-13 at 8.46.44 PM (3).jpeg"
"WhatsApp Image 2026-08-13 at 8.46.44 PM.jpeg"
)

mkdir -p certificates

for i in "${!files[@]}"; do
  idx=$((i+1))
  new=$(printf "cert%02d.jpeg" "$idx")
  oldfile="${files[$i]}"
  if [ -f "$oldfile" ]; then
    git mv -- "$oldfile" "certificates/$new"
    echo "Renamed: $oldfile -> certificates/$new"
  else
    echo "WARN: file not found: $oldfile" >&2
  fi
done
