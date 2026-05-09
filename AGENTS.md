# Obsidian Memory Agent

You are working inside an Obsidian vault.

Use `AI Memory/_index.md` as the routing map for long-term memory.

Before answering any user request, read `AI Memory/_index.md`, choose the relevant memory files, read only those files, and use active facts as context.

If no relevant facts are found, say: `В памяти релевантных данных нет.`

For coding and project work, read `AI Memory/_index.md` first, then read only the relevant project memory files such as `project-overview.md`, `architecture.md`, `dev-environment.md`, `commands.md`, `conventions.md`, `known-issues.md`, `tasks.md`, or `session-summaries.md`.

For multi-project vaults, keep a top-level hub note at the vault root that briefly describes each project and links to each project map or project overview note.

Do not scan the whole repository or vault by default.

Do not modify memory during normal question answering.

Do not invent personal facts about the user.

Do not store secrets such as passwords, tokens, API keys, or private keys.

Do not commit changes unless the user explicitly asks for a git commit.

After substantial coding or project work, propose updates to project memory when the session produced durable commands, decisions, conventions, known issues, or architecture context.

## Memory Lookup Commands

Normal questions automatically use lookup mode.

The user may also explicitly ask:

- `Read memory`
- `Use memory`
- `What do you remember?`
- `Прочитай память`
- `Используй память`
- `Что ты помнишь?`

If the user says `do not use memory` or `не используй память`, skip memory lookup for that answer.

## Smart Save

When the user says a short save command such as `Save`, `Save important`, `Save summary`, `Save project memory`, `Сохрани`, `Сохрани важное`, `Сохрани итог`, or `Сохрани память проекта`, run smart session save.

Smart session save means:

1. Review the current conversation and verified local project inspection from this session.
2. Extract only durable project knowledge useful for future AI coding sessions.
3. Prefer project memory files over personal memory files unless the user explicitly gave a personal fact.
4. Do not save guesses, temporary thoughts, transient terminal output, one-off errors, secrets, tokens, passwords, private keys, credentials, or unnecessary personal data.
5. Classify each candidate using `AI Memory/_index.md`.
6. Read each selected target file.
7. Check duplicates and conflicts.
8. Show a save plan before writing.
9. Write only after the user confirms with `Yes, save`, `Confirm`, `Write it`, `Да, запиши`, `Подтверждаю`, `Запиши`, or `OK`.
10. Append a log entry to `AI Memory/_log.md` after confirmed writes.

## Explicit Save

When saving memory from explicit save commands such as `Save to Obsidian: ...`, `Remember this in Obsidian: ...`, `Add this to memory: ...`, `Save this: ...`, `Update memory: ...`, `Write this to memory: ...`, `Сохрани в Obsidian: ...`, `Запомни это в Obsidian: ...`, `Добавь это в память: ...`, `Сохрани это: ...`, `Обнови память: ...`, or `Запиши это в память: ...`:

1. Extract only explicit user-provided facts.
2. Read `AI Memory/_index.md`.
3. Choose the best target memory file.
4. Check for duplicates.
5. Check for conflicts.
6. Prefer append-only edits.
7. Append a log entry to `AI Memory/_log.md`.

Always preserve history.

## Автономная запись в память

Этот проект запущен с включённым `--auto-write-memory`.

Агент может обновлять файлы `AI Memory/` без отдельного подтверждения перед каждой записью, если обнаружил устойчивую информацию, полезную для будущих AI coding sessions.

Разрешено автоматически сохранять:

- проверенные команды запуска, тестов, сборки, линтинга и диагностики
- архитектурные решения и связи компонентов
- настройки окружения разработки и setup steps
- conventions проекта и правила именования
- известные проблемы, ограничения, workaround и риски
- устойчивые задачи, roadmap items и follow-ups
- краткие итоги существенных coding sessions
- короткие markdown notes that summarize generated code, its purpose, and project-specific constraints or quirks

Перед записью всё равно нужно:

1. Прочитать `AI Memory/_index.md`.
2. Выбрать целевой memory-файл.
3. Прочитать целевой файл.
4. Проверить дубли по смыслу.
5. Проверить конфликты с активными фактами.
6. Предпочитать append-only изменения.
7. Добавить запись в `AI Memory/_log.md`.

Нельзя автоматически сохранять секреты, токены, пароли, private keys, credentials, private URLs, лишние персональные данные, догадки, временный вывод терминала, одноразовые ошибки или низкоценный шум.

When generating code, also write a short `.md` note that captures the code's purpose, notable constraints, and any important implementation quirks for future sessions.

Если есть конфликт, риск секрета, сомнение в устойчивости факта или запись требует изменения файлов вне `AI Memory/`, нужно сначала спросить пользователя.

Git commit и push всё равно запрещены без явной команды пользователя.

## Project Override File

If `AGENTS.override.md` exists in the project root, read it after `AGENTS.md` and treat it as a project-specific override.
Keep `AGENTS.md` as the baseline scaffold and use `AGENTS.override.md` for local project instructions that should not rewrite the shared template.

## Remotely Save

If `AI Memory/remotely-save.md` exists, read it before making decisions about Obsidian sync, vault layout, or cloud-backed memory.
Never write secrets, tokens, passwords, private keys, or Remotely Save credentials into memory files.
Ask before changing Remotely Save-related files unless `--unsafe-auto-write-memory` is explicitly enabled for this project.
