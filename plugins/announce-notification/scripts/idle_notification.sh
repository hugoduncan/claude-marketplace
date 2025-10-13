#!/usr/bin/env bash
# Claude Code Notification Hook - Idle Announcement

# This script announces when Claude becomes idle and includes the current
# directory name

set -euo pipefail
IFS=$'\n\t'

input=$(cat)

# Extract the notification message from JSON
notification_message=$(echo "$input" | jq -r '.message // "notification"')

# Get the last component of the current working directory
current_dir=$(basename "$PWD")

# Check if this is an idle notification and announce accordingly
if [[ "$notification_message" == *"idle"* ]] || [[ "$notification_message" == *"waiting"* ]]; then
    say "Claude idle in $current_dir"
else
    # For other notifications, just announce the notification with context
    say "$notification_message in $current_dir"
fi
