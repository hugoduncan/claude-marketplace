#!/usr/bin/env bash
# Claude Code Notification Hook - Idle Announcement

# This script announces when Claude becomes idle and includes the current
# directory name

set -euo pipefail
IFS=$'\n\t'

# Detect the appropriate TTS command based on platform and availability
# Returns the command name to use
# Exits with code 1 if no TTS command is available
detect_tts_command() {
    local os_type
    os_type=$(uname -s)

    case "$os_type" in
        Darwin)
            if command -v say >/dev/null 2>&1; then
                echo "say"
                return 0
            fi
            ;;
        Linux)
            # Try spd-say first (speech-dispatcher)
            if command -v spd-say >/dev/null 2>&1; then
                echo "spd-say"
                return 0
            fi
            # Fall back to espeak
            if command -v espeak >/dev/null 2>&1; then
                echo "espeak"
                return 0
            fi
            ;;
    esac

    # No TTS command available
    echo "Error: No text-to-speech command available." >&2
    echo "Please install one of the following:" >&2
    if [[ "$os_type" == "Linux" ]]; then
        echo "  - speech-dispatcher (spd-say): sudo apt install speech-dispatcher" >&2
        echo "  - espeak: sudo apt install espeak" >&2
    else
        echo "  - say command (should be available on macOS by default)" >&2
    fi
    return 1
}

# Announce a message using the specified TTS command
# Arguments:
#   $1 - TTS command name (say, spd-say, or espeak)
#   $2 - Message to announce
announce() {
    local tts_command="$1"
    local message="$2"

    "$tts_command" "$message"
}

# Main execution
input=$(cat)

# Extract the notification message from JSON
notification_message=$(echo "$input" | jq -r '.message // "notification"')

# Get the last component of the current working directory
current_dir=$(basename "$PWD")

# Detect available TTS command
tts_command=$(detect_tts_command) || exit 1

# Check if this is an idle notification and announce accordingly
if [[ "$notification_message" == *"idle"* ]] || [[ "$notification_message" == *"waiting"* ]]; then
    announce "$tts_command" "Claude idle in $current_dir"
else
    # For other notifications, just announce the notification with context
    announce "$tts_command" "$notification_message in $current_dir"
fi
