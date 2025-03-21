#!/usr/bin/env bash

# inspo: https://github.com/julian-heng/yabai-config/blob/master/scripts/open_iterm2.sh

if ! pgrep -f "ghostty" > /dev/null 2>&1; then
    open -a "/Applications/ghostty.app"
else
    # Create a new window
    script='tell application "ghostty" to create window with default profile'
    ! osascript -e "${script}" > /dev/null 2>&1 && {
        # Get pids for any app with "ghostty" and kill
        while IFS="" read -r pid; do
            kill -15 "${pid}"
        done < <(pgrep -f "ghostty")
        open -a "/Applications/ghostty.app"
    }
fi
