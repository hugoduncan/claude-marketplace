# Announce Notification Plugin

Audio notifications when Claude Code is idle or needs your input.

## Description

This plugin uses Claude Code's notification hooks to provide audio announcements when Claude becomes idle or is waiting for your input. The announcement includes the current directory name for context when working across multiple projects.

## Features

- Announces "Claude idle in [directory]" when Claude Code becomes idle
- Announces other notification messages with directory context
- Uses macOS text-to-speech (`say` command)

## Requirements

- macOS (uses the `say` command for text-to-speech)
- `jq` command-line JSON processor

Install jq if needed:
```bash
brew install jq
```

## How It Works

The plugin registers a notification hook that:
1. Receives notification events from Claude Code as JSON
2. Extracts the notification message
3. Gets the current working directory name
4. Uses text-to-speech to announce the event

## Files

- `settings.json` - Hook configuration
- `scripts/idle_notification.sh` - Notification script
- `package.json` - Plugin metadata

## Installation

This plugin is part of the mcp-clj-tools marketplace. Install it through the Claude Code plugin system.
