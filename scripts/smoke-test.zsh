#!/usr/bin/env zsh
set -euo pipefail

SCRIPT_PATH="${0:A}"
SCRIPT_DIR="${SCRIPT_PATH:h}"
REPO_ROOT="${SCRIPT_DIR:h}"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/codex-project-smoke.XXXXXX")"
STUB_BIN="$TMP_ROOT/bin"
SANDBOX_HOME="$(mktemp -d "${TMPDIR:-/tmp}/codex-project-home.XXXXXX")"

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
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
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
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$doctor_dir"
  "$REPO_ROOT/bin/codex-project" --init-only >/dev/null
  git init -q
  "$REPO_ROOT/bin/codex-project" doctor >/dev/null
  "$REPO_ROOT/bin/codex-project" lint >/dev/null
)

print -r -- "smoke-test: override"
override_dir="$(mktemp -d "${TMP_ROOT}/override.XXXXXX")"
(
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$override_dir"
  "$REPO_ROOT/bin/codex-project" --override --init-only >/dev/null
  check_file "$override_dir/AGENTS.override.md"
  [[ ! -e "$override_dir/AGENTS.md" ]]
  check_file "$override_dir/AI Memory/_index.md"
)

print -r -- "smoke-test: settings"
settings_home="$(mktemp -d "${TMP_ROOT}/home.XXXXXX")"
settings_dir="$TMP_ROOT/settings"
settings_vault="$(mktemp -d "${TMP_ROOT}/settings-vault.XXXXXX")"
(
  export HOME="$settings_home"
  export XDG_CONFIG_HOME="$settings_home/.config"
  export CODEX_MEMORY_LANG=ru
  export CODEX_MEMORY_OBSIDIAN_ROOT="$settings_vault"
  export CODEX_MEMORY_DEFAULT_REMOTELY_SAVE=1
  export CODEX_MEMORY_DEFAULT_AUTO_WRITE_MEMORY=0
  export CODEX_MEMORY_DEFAULT_VAULT_MAP=1
  mkdir -p "$settings_dir"
  cd "$settings_dir"
  "$REPO_ROOT/bin/codex-project" --settings >/dev/null
  check_file "$XDG_CONFIG_HOME/codex-project/settings.env"
  unset CODEX_MEMORY_LANG CODEX_MEMORY_OBSIDIAN_ROOT CODEX_MEMORY_DEFAULT_REMOTELY_SAVE CODEX_MEMORY_DEFAULT_AUTO_WRITE_MEMORY CODEX_MEMORY_DEFAULT_VAULT_MAP
  "$REPO_ROOT/bin/codex-project" --init-only >/dev/null
  check_file "$settings_dir/AGENTS.md"
  check_file "$settings_dir/AI Memory/_index.md"
  check_file "$settings_dir/AI Memory/map.md"
  check_file "$settings_dir/AI Memory/remotely-save.md"
  grep -Fq -- "CODEX_MEMORY_DEFAULT_VAULT_MAP" "$XDG_CONFIG_HOME/codex-project/settings.env"
  check_file "$settings_vault/settings/AI Memory/_index.md"
  check_file "$settings_vault/settings/AI Memory/map.md"
  check_file "$settings_vault/settings/AI Memory/remotely-save.md"
)

print -r -- "smoke-test: remotely-save"
remote_dir="$(mktemp -d "${TMP_ROOT}/remote.XXXXXX")"
(
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$remote_dir"
  "$REPO_ROOT/bin/codex-project" --remotely-save --init-only >/dev/null
  check_file "$remote_dir/AI Memory/remotely-save.md"
  check_file "$remote_dir/docs/remotely-save.md"
)

print -r -- "smoke-test: obsidian-root"
vault_dir="$(mktemp -d "${TMP_ROOT}/vault.XXXXXX")"
(
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$TMP_ROOT"
  "$REPO_ROOT/bin/codex-project" --obsidian-root "$vault_dir" --project-name obsidian-test --init-only >/dev/null
  check_file "$TMP_ROOT/AGENTS.md"
  check_file "$TMP_ROOT/map.md"
  check_file "$vault_dir/obsidian-test/AI Memory/_index.md"
  check_file "$vault_dir/obsidian-test/AI Memory/map.md"
  check_gitignore "$TMP_ROOT/.gitignore"
)

print -r -- "smoke-test: vault-map"
vault_map_dir="$(mktemp -d "${TMP_ROOT}/vault-map.XXXXXX")"
(
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$vault_map_dir"
  "$REPO_ROOT/bin/codex-project" vault-map >/dev/null
  check_file "$vault_map_dir/map.md"
)

print -r -- "smoke-test: code-note"
code_note_dir="$(mktemp -d "${TMP_ROOT}/code-note.XXXXXX")"
(
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$code_note_dir"
  "$REPO_ROOT/bin/codex-project" vault-map >/dev/null
  "$REPO_ROOT/bin/codex-project" note --title "Smoke Note" >/dev/null
  check_file "$code_note_dir/code-note.md"
  grep -Fq -- "# Smoke Note" "$code_note_dir/code-note.md"
  grep -Fq -- "[[map]]" "$code_note_dir/code-note.md"
)

print -r -- "smoke-test: code-note source"
code_source_dir="$(mktemp -d "${TMP_ROOT}/code-source.XXXXXX")"
(
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$code_source_dir"
  mkdir -p src
  print -r -- "console.log('ok');" > src/my-feature.ts
  "$REPO_ROOT/bin/codex-project" vault-map >/dev/null
  "$REPO_ROOT/bin/codex-project" note --source src/my-feature.ts --title "My Feature" >/dev/null
  check_file "$code_source_dir/src/my-feature.code.md"
  grep -Fq -- "# My Feature" "$code_source_dir/src/my-feature.code.md"
  grep -Fq -- "\`src/my-feature.ts\`" "$code_source_dir/src/my-feature.code.md"
)

print -r -- "smoke-test: save"
save_dir="$(mktemp -d "${TMP_ROOT}/save.XXXXXX")"
(
  export HOME="$SANDBOX_HOME"
  export XDG_CONFIG_HOME="$HOME/.config"
  cd "$save_dir"
  "$REPO_ROOT/bin/codex-project" --init-only >/dev/null
  "$REPO_ROOT/bin/codex-project" save --title checkpoint --note "Smoke test passed" >/dev/null
  grep -Fq -- "Smoke test passed" "$save_dir/AI Memory/session-summaries.md"
)

print -r -- "smoke-test: done"
