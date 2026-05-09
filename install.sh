#!/usr/bin/env zsh
set -euo pipefail

REPO_ROOT="${0:A:h}"
BIN_DIR="$HOME/.local/bin"
TARGET="$BIN_DIR/codex-project"

if [[ ! -x "$REPO_ROOT/bin/codex-project" ]]; then
  print -u2 -r -- "install.sh: expected executable at $REPO_ROOT/bin/codex-project"
  exit 1
fi

mkdir -p "$BIN_DIR"
ln -sf "$REPO_ROOT/bin/codex-project" "$TARGET"
chmod +x "$REPO_ROOT/bin/codex-project"

print -r -- "Installed codex-project -> $TARGET"
print -r -- "Use English templates: codex-project"
print -r -- "Use Russian templates: codex-project --lang ru"
print -r -- "Windows via WSL: bin/codex-project.cmd or bin/codex-project.ps1"
print -r -- "Create an override file: codex-project --override"
print -r -- "Add Remotely Save docs: codex-project --remotely-save"
print -r -- "Save a session summary: codex-project save --title checkpoint --note '...'"
print -r -- "Run the repo health check: codex-project doctor"
print -r -- "Run the shorter health check: codex-project lint"
print -r -- "Store memory in an Obsidian vault: codex-project --obsidian-root /path/to/vault"
print -r -- "Use cloud memory: codex-project --cloud-root /path/to/cloud/AI-Memory"
print -r -- "Enable autonomous memory writes: codex-project --auto-write-memory"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    print -r -- ""
    print -r -- "Add this to your shell profile if codex-project is not found:"
    print -r -- "export PATH=\"\$HOME/.local/bin:\$PATH\""
    ;;
esac
