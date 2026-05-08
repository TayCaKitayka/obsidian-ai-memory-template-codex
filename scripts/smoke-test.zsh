#!/usr/bin/env zsh
set -euo pipefail

SCRIPT_PATH="${0:A}"
SCRIPT_DIR="${SCRIPT_PATH:h}"
REPO_ROOT="${SCRIPT_DIR:h}"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/codex-project-smoke.XXXXXX")"
STUB_BIN="$TMP_ROOT/bin"

cleanup() {
  rm -rf "$TMP_ROOT"
}

trap cleanup EXIT INT TERM

mkdir -p "$STUB_BIN"

cat > "$STUB_BIN/codex" <<'EOF'
#!/usr/bin/env zsh
print -r -- "codex stub"
EOF
chmod +x "$STUB_BIN/codex"

export PATH="$STUB_BIN:$PATH"

check_file() {
  local file="$1"
  [[ -e "$file" ]] || {
    print -u2 -r -- "smoke-test: missing file: $file"
    exit 1
  }
}

check_gitignore() {
  local file="$1"
  grep -Fxq -- "/AI Memory/" "$file"
  grep -Fxq -- "/AI Memory/**" "$file"
  grep -Fxq -- "*.memory.local.md" "$file"
}

check_gitignored() {
  local dir="$1"
  git -C "$dir" check-ignore -q -- "AI Memory/_index.md"
}

print -r -- "smoke-test: syntax checks"
zsh -n "$REPO_ROOT/install.sh"
zsh -n "$REPO_ROOT/bin/codex-project"

print -r -- "smoke-test: init-only"
init_dir="$(mktemp -d "${TMP_ROOT}/init.XXXXXX")"
(
  cd "$init_dir"
  "$REPO_ROOT/bin/codex-project" --init-only >/dev/null
  git init -q
  check_file "$init_dir/AGENTS.md"
  check_file "$init_dir/AI Memory/_index.md"
  check_file "$init_dir/AI Memory/map.md"
  check_gitignore "$init_dir/.gitignore"
  check_gitignored "$init_dir"
)

print -r -- "smoke-test: doctor"
doctor_dir="$(mktemp -d "${TMP_ROOT}/doctor.XXXXXX")"
(
  cd "$doctor_dir"
  "$REPO_ROOT/bin/codex-project" --init-only >/dev/null
  git init -q
  "$REPO_ROOT/bin/codex-project" doctor >/dev/null
  "$REPO_ROOT/bin/codex-project" lint >/dev/null
)

print -r -- "smoke-test: override"
override_dir="$(mktemp -d "${TMP_ROOT}/override.XXXXXX")"
(
  cd "$override_dir"
  "$REPO_ROOT/bin/codex-project" --override --init-only >/dev/null
  check_file "$override_dir/AGENTS.override.md"
  [[ ! -e "$override_dir/AGENTS.md" ]]
  check_file "$override_dir/AI Memory/_index.md"
)

print -r -- "smoke-test: remotely-save"
remote_dir="$(mktemp -d "${TMP_ROOT}/remote.XXXXXX")"
(
  cd "$remote_dir"
  "$REPO_ROOT/bin/codex-project" --remotely-save --init-only >/dev/null
  check_file "$remote_dir/AI Memory/remotely-save.md"
  check_file "$remote_dir/docs/remotely-save.md"
)

print -r -- "smoke-test: obsidian-root"
vault_dir="$(mktemp -d "${TMP_ROOT}/vault.XXXXXX")"
(
  cd "$TMP_ROOT"
  "$REPO_ROOT/bin/codex-project" --obsidian-root "$vault_dir" --project-name obsidian-test --init-only >/dev/null
  check_file "$TMP_ROOT/AGENTS.md"
  check_file "$vault_dir/obsidian-test/AI Memory/_index.md"
  check_file "$vault_dir/obsidian-test/AI Memory/map.md"
  check_gitignore "$TMP_ROOT/.gitignore"
)

print -r -- "smoke-test: save"
save_dir="$(mktemp -d "${TMP_ROOT}/save.XXXXXX")"
(
  cd "$save_dir"
  "$REPO_ROOT/bin/codex-project" --init-only >/dev/null
  "$REPO_ROOT/bin/codex-project" save --title checkpoint --note "Smoke test passed" >/dev/null
  grep -Fq -- "Smoke test passed" "$save_dir/AI Memory/session-summaries.md"
)

print -r -- "smoke-test: done"
