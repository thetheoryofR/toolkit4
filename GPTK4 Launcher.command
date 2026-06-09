#!/usr/bin/env bash
# Double-clickable launcher: opens the GPTK4 GUI menu.
# Keep this file next to the 'gptk4' and 'gptk4-gui' scripts.
cd "$(dirname "$0")"
chmod +x gptk4 gptk4-gui 2>/dev/null || true
exec ./gptk4-gui
