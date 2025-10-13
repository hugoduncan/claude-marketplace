# mcp-clj-tools Plugin Marketplace

A Claude Code plugin marketplace containing productivity-enhancing plugins.

## Overview

This repository serves as a plugin marketplace for Claude Code,
providing a collection of plugins that extend Claude Code's
functionality with custom hooks, tools, and integrations.

## Available Plugins

### announce-notification

Audio notifications when Claude Code is idle or needs your input.

**Features:**
- Announces "Claude idle in [directory]" when Claude becomes idle
- Provides audio feedback with directory context
- Works seamlessly across multiple projects

**Requirements:**
- macOS (uses `say` command)
- `jq` JSON processor

[Full documentation](plugins/announce-notification/README.md)

## Installation

Add this marketplace to Claude Code:

```
/plugin marketplace add hugoduncan/claude-marketplace
```

Then install plugins from this marketplace. For example, to install the
announce-notification plugin:

```
/plugin install announce-notification
```
