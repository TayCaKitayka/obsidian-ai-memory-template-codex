#!/usr/bin/env zsh
set -euo pipefail

REPO_ROOT="${0:A:h}"
BIN_DIR="$HOME/.local/bin"
TARGET="$BIN_DIR/codex-project"

mkdir -p "$BIN_DIR"
ln -sf "$REPO_ROOT/bin/codex-project" "$TARGET"
chmod +x "$REPO_ROOT/bin/codex-project"

print "Installed codex-project -> $TARGET"
print "Use English templates: codex-project"
print "Use Russian templates: codex-project --lang ru"
print "Use cloud memory: codex-project --cloud-root /path/to/cloud/AI-Memory"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    print ""
    print "Add this to your shell profile if codex-project is not found:"
    print "export PATH=\"\$HOME/.local/bin:\$PATH\""
    ;;
esac
