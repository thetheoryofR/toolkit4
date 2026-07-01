#!/usr/bin/env bash
# Builds "GPTK4 Launcher.app" in /Applications so the launcher can be
# opened like any normal Mac app (Launchpad, Spotlight, Dock).
# Double-click this file once; re-run it after updating the scripts.
set -euo pipefail
cd "$(dirname "$0")"

APP="/Applications/GPTK4 Launcher.app"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cat > "$TMP/main.applescript" <<'EOF'
set gui to POSIX path of (path to resource "gptk4-gui")
do shell script "/bin/bash " & quoted form of gui & " >/dev/null 2>&1 &"
EOF

rm -rf "$APP"
osacompile -o "$APP" "$TMP/main.applescript"
cp gptk4 gptk4-gui "$APP/Contents/Resources/"
chmod +x "$APP/Contents/Resources/gptk4" "$APP/Contents/Resources/gptk4-gui"

echo
echo "✔ Created: $APP"
echo "  You can now open 'GPTK4 Launcher' from Launchpad or Spotlight."
read -r -p "Press Enter to close…"
