# Clojure LSP Plugin

Provides [clojure-lsp](https://clojure-lsp.io) integration for Claude Code, enabling real-time diagnostics, code navigation, and language awareness for Clojure, ClojureScript, and EDN files.

## Prerequisites

Install clojure-lsp before using this plugin:

**macOS (Homebrew):**
```bash
brew install clojure-lsp/brew/clojure-lsp-native
```

**Linux/macOS (Script):**
```bash
curl -fsSL https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install | bash
```

**Windows:**
```bash
scoop bucket add scoop-clojure https://github.com/littleli/scoop-clojure
scoop install clojure-lsp
```

See [clojure-lsp installation docs](https://clojure-lsp.io/installation/) for more options.

## Features

- Real-time error and warning diagnostics
- Go to definition
- Find references
- Hover documentation
- Symbol information

## Supported File Types

- `.clj` - Clojure
- `.cljs` - ClojureScript
- `.cljc` - Clojure/ClojureScript
- `.edn` - EDN data files
