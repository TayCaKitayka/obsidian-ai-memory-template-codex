# Obsidian AI Memory Template

A small Markdown memory scaffold for AI coding agents such as Codex.

It creates project-local memory files that an agent can read through `AGENTS.md` before answering or editing code.

## Included

- `AGENTS.md` - instructions for agent memory lookup and smart save.
- `templates/AI Memory/` - empty personal and project memory templates.
- `locales/ru/` - Russian agent instructions and memory templates.
- `bin/codex-project` - helper command that initializes memory in the current project and starts Codex.
- `install.sh` - local installer that symlinks `codex-project` into `~/.local/bin`.

## Not Included

- Personal facts.
- Private Obsidian notes.
- Secrets, tokens, passwords, private keys.

## Install

Clone this repository, then run:

```bash
./install.sh
```

If needed, add `~/.local/bin` to your `PATH`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Use In A Project

From any project directory:

```bash
codex-project
```

The command will:

- create `AGENTS.md` if missing;
- create `AI Memory/` if missing;
- copy empty memory templates;
- replace `YYYY-MM-DD` with today's date;
- skip existing files instead of overwriting them;
- start `codex -C "$PWD"`.

To initialize without starting Codex:

```bash
codex-project --init-only
```

## Cloud / Synced Memory

By default, every project gets its own local `AI Memory/` directory.

To keep project memory in a shared cloud folder, pass `--cloud-root`:

```bash
codex-project --cloud-root "$HOME/Library/Mobile Documents/com~apple~CloudDocs/AI Memory Projects"
```

The command will create:

```text
<cloud-root>/<project-name>/AI Memory/
```

and link it into the current project:

```text
your-project/AI Memory -> <cloud-root>/<project-name>/AI Memory
```

You can set a default cloud root:

```bash
export CODEX_MEMORY_CLOUD_ROOT="$HOME/Library/Mobile Documents/com~apple~CloudDocs/AI Memory Projects"
```

If the current project already has a regular `AI Memory/` directory, `codex-project` will not replace it automatically. It will make a non-destructive first copy into the cloud folder with `rsync --ignore-existing`, then warn you. For ongoing cross-device sync, move or rename the existing local directory first, then rerun with `--cloud-root` so the project can use a symlink.

To use a custom cloud folder name:

```bash
codex-project --cloud-root "$HOME/Cloud/AI Memory Projects" --project-name mobile_app
```

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

Both localizations understand English and Russian memory commands.

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

## Memory Files

- `project-overview.md` - purpose, scope, and durable project context.
- `architecture.md` - architecture, components, and technical decisions.
- `dev-environment.md` - local setup, dependencies, and requirements.
- `commands.md` - verified run, test, lint, build, and diagnostic commands.
- `conventions.md` - coding style, file structure, and naming rules.
- `known-issues.md` - known bugs, limitations, risks, and workarounds.
- `tasks.md` - durable tasks, roadmap items, and follow-ups.
- `session-summaries.md` - concise summaries of substantial coding sessions.

## Safety

Do not store secrets in memory files.

Keep private memory out of public repositories. The `.gitignore` excludes a root-level `AI Memory/` directory so this template repository does not accidentally track a local private memory folder.
