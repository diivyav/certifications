#!/bin/bash
# scripts/rename_cert_images.sh
# Run this in your local clone of the repository to rename all WhatsApp image files
# into a certificates/ folder with simple names: cert01.jpeg, cert02.jpeg, ...
# Usage:
#   chmod +x scripts/rename_cert_images.sh
#   ./scripts/rename_cert_images.sh
# After the script runs commit and push: git push

set -euo pipefail

# Make a folder for renamed files
mkdir -p certificates

# Map of old filenames (exact) to new filenames
declare -a old=(
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

# new filenames: cert01.jpeg ... cert25.jpeg
for i in "${!old[@]}"; do
  idx=$((i+1))
  new=$(printf "cert%02d.jpeg" "$idx")
  oldfile="${old[$i]}"
  if [ -f "$oldfile" ]; then
    git mv -- "$oldfile" "certificates/$new"
    echo "Renamed: $oldfile -> certificates/$new"
  else
    echo "WARN: file not found: $oldfile" >&2
  fi
done

# Update README.md to reference new filenames (this replaces any occurrences of the old names)
# This sed command creates a backup README.md.bak and writes the new README.md in-place.
cp README.md README.md.bak

# For each old filename replace with certificates/certNN.jpeg (handles spaces and parens)
for i in "${!old[@]}"; do
  idx=$((i+1))
  newpath="certificates/$(printf "cert%02d.jpeg" "$idx")"
  # Escape characters for sed
  old_escaped=$(printf '%s' "${old[$i]}" | sed -e 's/[\/&]/\\&/g')
  new_escaped=$(printf '%s' "$newpath" | sed -e 's/[\/&]/\\&/g')
  sed -i "s/$old_escaped/$new_escaped/g" README.md
done

echo "\nDone. Review README.md and then commit/push the changes if everything looks right."

echo "If you want me to update the README on GitHub after you push these renames, tell me and I will commit the README update for you."