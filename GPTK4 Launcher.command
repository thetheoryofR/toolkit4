#!/usr/bin/env bash
# Double-clickable launcher: runs setup if needed, then starts Steam
# through CrossOver GPTK4. Keep this file next to the 'gptk4' script.
cd "$(dirname "$0")"

if [[ ! -d "/Applications/CrossOver GPTK4.app" ]]; then
    echo "First run detected — performing setup…"
    ./gptk4 setup || { echo; echo "Setup failed. See messages above."; read -r -p "Press Enter to close…"; exit 1; }
fi

./gptk4 launch
