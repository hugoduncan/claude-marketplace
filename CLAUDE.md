# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Code plugin marketplace repository named "mcp-clj-tools". It contains plugin definitions and source code for Claude Code plugins.

## Repository Structure

- `.claude-plugin/marketplace.json` - Marketplace manifest defining available plugins
- `plugins/` - Directory containing plugin source code (referenced by marketplace.json)

## Marketplace Configuration

The marketplace manifest (`.claude-plugin/marketplace.json`) defines:
- Marketplace name and owner information
- List of plugins with their metadata (name, source path, description, version, author)

When adding or modifying plugins:
1. Create the plugin source code in the appropriate directory under `plugins/`
2. Update the marketplace.json to reference the new plugin with correct source path
3. Ensure the source path in marketplace.json matches the actual plugin directory

## Plugin Structure

Each plugin referenced in marketplace.json should have:
- A unique name
- A source directory path relative to repository root
- A description of its functionality
- Version information
- Author metadata```

## Adding New Plugins

To add a new plugin to this marketplace:

1. Create a new directory under `plugins/`
2. Add plugin files (`package.json`, `settings.json`, scripts, etc.)
3. Update `.claude-plugin/marketplace.json` to include the new plugin
4. Document the plugin with a README.md
