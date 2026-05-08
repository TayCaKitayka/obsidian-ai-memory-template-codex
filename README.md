# Obsidian AI Memory Template

This repository is a lightweight, Codex-first Markdown memory scaffold for Obsidian vaults and AI coding agents.
It stays small, explicit, and safe.

## What This Is

- A reusable scaffold for `AGENTS.md`, `AGENTS.override.md`, and `AI Memory/` templates.
- A helper command for initializing memory in a project and launching Codex.
- A safe documentation set for Obsidian Remotely Save workflows.

## Why This Exists

Codex works better when it has a small, predictable place for durable project context.
This project gives it that place without turning the repo into a large wiki or automation stack.

## What It Is Not

- Not a full knowledge base.
- Not a large claude-obsidian clone.
- Not an ingest pipeline.
- Not an autonomous wiki builder.
- Not a place for secrets, tokens, passwords, or private plugin config.

## Quick Start

```bash
./install.sh
codex-project --help
codex-project --init-only
```

If `codex-project` is not found after install, add `~/.local/bin` to your `PATH`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Install

Clone this repository and run:

```bash
./install.sh
```

The installer symlinks `bin/codex-project` into `~/.local/bin`.

If you move the repository later, rerun `./install.sh` so the symlink points at the current clone.

## Usage

Run the initializer from any project directory:

```bash
codex-project
```

This will:

- create `AGENTS.md` or `AGENTS.override.md`;
- create `AI Memory/` and copy the memory templates;
- replace `YYYY-MM-DD` with today's date;
- keep existing files instead of overwriting them;
- update `.gitignore` with safe AI memory ignore rules;
- start `codex -C "$PWD"` unless `--init-only` is used.

To initialize without starting Codex:

```bash
codex-project --init-only
```

To see all options:

```bash
codex-project --help
```

Useful subcommands:

```bash
codex-project doctor
codex-project lint
codex-project save --title "checkpoint" --note "Smoke test passed"
```

## Codex CLI Examples

Pass flags to Codex after `--`:

```bash
codex-project -- --model gpt-5.1
codex-project -- --ask-for-approval on-request
codex-project -- --sandbox workspace-write
codex-project -- --search
```

## AGENTS.md Compatibility

`AGENTS.md` is the baseline agent instruction file.
It tells Codex how to route memory lookup, how to save durable facts, and when to avoid secrets.

If the project needs local overrides without rewriting the baseline, use `AGENTS.override.md`.

## AGENTS.override.md

Use `AGENTS.override.md` when a project needs extra instructions that are specific to the current vault or repo.
`codex-project --override` creates `AGENTS.override.md` instead of `AGENTS.md` and leaves any existing `AGENTS.md` untouched.

## AI Memory Layout

The scaffold creates a small set of markdown files under `AI Memory/`:

- `project-overview.md`
- `architecture.md`
- `dev-environment.md`
- `commands.md`
- `conventions.md`
- `known-issues.md`
- `tasks.md`
- `session-summaries.md`
- optional `remotely-save.md`

The memory index is the routing map for long-term memory.
The graph stays small, but it becomes more useful when related notes link to each other:
`[[project-overview]]`, `[[architecture]]`, `[[commands]]`, `[[tasks]]`, and `[[session-summaries]]`.

## Cloud / Symlink Workflow

`codex-project --cloud-root DIR` stores `AI Memory/` in a shared cloud folder and links it back into the project when possible.

If the directory is an Obsidian vault, use `--obsidian-root` instead. It is the same mechanism with a more explicit name.

Example:

```bash
codex-project --cloud-root "$HOME/Cloud/AI Memory Projects"
```

Obsidian vault example:

```bash
codex-project --obsidian-root "$HOME/Obsidian/MyVault"
```

You can also set a default cloud root:

```bash
export CODEX_MEMORY_CLOUD_ROOT="$HOME/Cloud/AI Memory Projects"
```

Recommended layouts:

1. Full vault sync: the repo lives inside an Obsidian vault and Remotely Save syncs the whole vault.
2. Cloud AI Memory folder: `AI Memory/` is a symlink to a cloud-backed folder.
3. Markdown-only sync: only the memory notes sync, while `.obsidian/` stays local.

## Remotely Save Support

Obsidian Remotely Save can sync vault files across devices, but the sync scope should be explicit.

- Do not generate or commit credentials.
- Do not assume the user wants to sync `.obsidian/`.
- Treat Remotely Save provider settings as private configuration.
- Prefer markdown-only sync unless the user explicitly wants broader vault sync.

Run the helper mode to add safe documentation:

```bash
codex-project --remotely-save
```

This adds a memory note for safe sync layouts and a project docs note in `docs/remotely-save.md` when needed.

## Safety Model

- Never store secrets, tokens, passwords, private keys, or private URLs in memory files.
- Never auto-write Remotely Save credentials.
- Ask before changing Remotely Save-related files unless unsafe auto-write mode is enabled.
- Keep writes append-only when possible.
- Prefer explicit confirmation for durable facts that are not yet stable.

## Git Ignore Behavior

New projects get a safe `.gitignore` block for AI memory files:

- `AI Memory/`
- `AI Memory/**`
- `*.memory.local.md`

The block is appended only when entries are missing.

## Doctor Mode

Check a project before using it:

```bash
codex-project doctor
```

Doctor verifies shell availability, Codex availability, template resolution, directory writability, memory files, Git ignore status, and optional cloud-root setup.

## Comparison With claude-obsidian

`claude-obsidian` is a larger Obsidian wiki and knowledge-engine style project.
This repository is intentionally smaller.

It focuses on:

- Codex-first project memory
- explicit routing through `AI Memory/_index.md`
- safe, reviewable file creation
- simple shell workflows
- Remotely Save documentation without credential automation

It intentionally avoids:

- ingest pipelines
- autonomous wiki building
- large-scale note synthesis
- complex automation layers

## Troubleshooting

- If `codex-project` is missing after install, make sure `~/.local/bin` is in your `PATH`.
- If template resolution fails, set `CODEX_MEMORY_TEMPLATE_ROOT` to the repository root that contains `templates/AI Memory/`.
- If `doctor` reports that `AI Memory/` is tracked by Git, the project is not yet using the scaffolded ignore rules.
- If you want a shared memory folder, create it first and rerun with `--cloud-root`.

## Localization

English is the default:

```bash
codex-project --lang en
```

Russian templates are available:

```bash
codex-project --lang ru
```

You can also set a default language:

```bash
export CODEX_MEMORY_LANG=ru
```

## Memory Workflow

Normal questions should use lookup mode:

1. Read `AI Memory/_index.md`.
2. Select relevant memory files.
3. Read only selected files.
4. Answer using active facts.

Saving explicit facts:

```text
Save to Obsidian: project run command is npm run dev.
```

or:

```text
Сохрани в Obsidian: команда запуска проекта - npm run dev.
```

Smart session save:

```text
Save
```

or:

```text
Сохрани
```

The agent should propose what to save, check duplicates and conflicts, then write only after confirmation.

English confirmation:

```text
Yes, save
```

Russian confirmation:

```text
Да, запиши
```
