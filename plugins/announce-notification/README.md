# Announce Notification Plugin

Audio notifications when Claude Code is idle or needs your input.

## Description

This plugin uses Claude Code's notification hooks to provide audio announcements when Claude becomes idle or is waiting for your input. The announcement includes the current directory name for context when working across multiple projects.

## Features

- Announces "Claude idle in [directory]" when Claude Code becomes idle
- Announces other notification messages with directory context
- Cross-platform text-to-speech support:
  - macOS: Uses `say` command
  - Linux: Automatically detects and uses `spd-say` (speech-dispatcher) or falls back to `espeak`

## Requirements

### All Platforms

- `jq` command-line JSON processor

### macOS

- `say` command (built-in on macOS)

### Linux

One of the following text-to-speech engines (the plugin will automatically use the first available):

1. **speech-dispatcher** (recommended) - provides `spd-say` command
2. **espeak** - fallback option

## Installation

### macOS

Install jq using Homebrew:
```bash
brew install jq
```

The `say` command is available by default on macOS.

### Linux

#### Debian/Ubuntu
```bash
# Install jq and speech-dispatcher (recommended)
sudo apt install jq speech-dispatcher

# Or install jq and espeak (alternative)
sudo apt install jq espeak
```

#### Fedora/RHEL
```bash
# Install jq and speech-dispatcher (recommended)
sudo dnf install jq speech-dispatcher

# Or install jq and espeak (alternative)
sudo dnf install jq espeak
```

#### Arch Linux
```bash
# Install jq and speech-dispatcher (recommended)
sudo pacman -S jq speech-dispatcher

# Or install jq and espeak (alternative)
sudo pacman -S jq espeak
```

## How It Works

The plugin registers a notification hook that:
1. Receives notification events from Claude Code as JSON
2. Extracts the notification message
3. Detects the platform and available text-to-speech command:
   - macOS: Uses `say`
   - Linux: Tries `spd-say` first, falls back to `espeak` if unavailable
4. Gets the current working directory name
5. Uses text-to-speech to announce the event

## Files

- `hooks/hooks.json` - Hook configuration
- `scripts/idle_notification.sh` - Notification script
- `package.json` - Plugin metadata

## Plugin Installation

This plugin is part of the mcp-clj-tools marketplace. Install it through the Claude Code plugin system.
