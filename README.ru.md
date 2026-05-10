# Шаблон Obsidian AI Memory

Это лёгкий Markdown-шаблон памяти для Obsidian vault и AI coding agents, ориентированный на Codex.
Он остаётся маленьким, явным и безопасным.

## Что Это

- Базовый шаблон для `AGENTS.md`, `AGENTS.override.md` и `AI Memory/`.
- Команда для инициализации памяти в проекте и запуска Codex.
- Windows launcher-скрипты для запуска того же zsh-core через WSL.
- Безопасная документация для сценариев Obsidian Remotely Save.

## Зачем Это Нужно

Codex лучше работает, когда у него есть небольшое и предсказуемое место для долговременного контекста проекта.
Этот проект даёт именно это место, не превращаясь в большую вики или систему автоматизации.

## Чем Это Не Является

- Не полноценная knowledge base.
- Не большой клон claude-obsidian.
- Не ingest-пайплайн.
- Не автономный wiki builder.
- Не место для секретов, токенов, паролей или приватного конфигa плагинов.

## Быстрый Старт

```bash
./install.sh
codex-project --help
codex-project --init-only
```

Если `codex-project` не находится после установки, добавь `~/.local/bin` в `PATH`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Установка

Склонируй этот репозиторий и запусти:

```bash
./install.sh
```

Установщик создаёт симлинк `bin/codex-project` в `~/.local/bin`.
На Windows используй `bin/codex-project.cmd` или `bin/codex-project.ps1` при установленном WSL.

Если потом перенесёшь репозиторий, снова запусти `./install.sh`, чтобы симлинк указывал на актуальную копию.
Пользователям Windows не нужен `install.sh`; им стоит запускать launcher-скрипты из корня репозитория или добавить репозиторий в PATH удобным для Windows способом.

## Использование

Запусти инициализатор из любой папки проекта:

```bash
codex-project
```

Это:

- создаст `.codex-project/` и поместит реальные файлы проекта туда;
- создаст `AGENTS.md` или `AGENTS.override.md` как симлинки в `.codex-project/`;
- создаст `AI Memory/` как симлинк в `.codex-project/`;
- заменит `YYYY-MM-DD` на текущую дату;
- не будет перезаписывать существующие файлы;
- обновит `.gitignore` безопасными правилами для AI memory;
- запустит `codex -C "$PWD"`, если не указан `--init-only`.

Чтобы только инициализировать без запуска Codex:

```bash
codex-project --init-only
```

Полезные подкоманды:

```bash
codex-project doctor
codex-project lint
codex-project vault-map
codex-project code-note --title "Моя Фича"
codex-project code-note --source src/my-feature.ts
codex-project note --source src/my-feature.ts
codex-project save --title "checkpoint" --note "Smoke test passed"
```

## Глобальные Настройки

Один раз запусти мастер настроек:

```bash
codex-project --settings
```

Это создаст `~/.config/codex-project/settings.env` и будет автоматически использоваться во всех проектах.
Если stdin не интерактивный, файл будет записан из текущих значений окружения.
После выбора языка мастер переключается на английский или русский интерфейс.

Через этот файл удобно задать значения по умолчанию:

- `CODEX_MEMORY_LANG`
- `CODEX_MEMORY_OBSIDIAN_ROOT` или `CODEX_MEMORY_CLOUD_ROOT`
- `CODEX_MEMORY_PROJECT_NAME`
- `CODEX_MEMORY_DEFAULT_REMOTELY_SAVE`
- `CODEX_MEMORY_DEFAULT_AUTO_WRITE_MEMORY`
- `CODEX_MEMORY_DEFAULT_VAULT_MAP`

Также поддерживается локальный override-файл `./.codex-project.env`, но нормальный сценарий — именно глобальный файл.

## Примеры Codex CLI

Пробрасывай флаги в Codex после `--`:

```bash
codex-project -- --model gpt-5.1
codex-project -- --ask-for-approval on-request
codex-project -- --sandbox workspace-write
codex-project -- --search
```

## Совместимость С AGENTS.md

`AGENTS.md` это базовый файл инструкций для агента.
Он объясняет, как читать память, как сохранять устойчивые факты и как избегать секретов.

Если нужны локальные переопределения без переписывания базового шаблона, используй `AGENTS.override.md`.

## AGENTS.override.md

Используй `AGENTS.override.md`, когда проекту нужны дополнительные инструкции, специфичные для текущего vault или репозитория.
`codex-project --override` создаёт `AGENTS.override.md` вместо `AGENTS.md` и не трогает уже существующий `AGENTS.md`.

## Раскладка AI Memory

Шаблон создаёт небольшой набор markdown-файлов в `AI Memory/`:

- `project-overview.md`
- `architecture.md`
- `dev-environment.md`
- `commands.md`
- `conventions.md`
- `known-issues.md`
- `tasks.md`
- `session-summaries.md`
- `map.md`
- `remotely-save.md` при необходимости

Индекс памяти — это карта маршрутизации долговременной памяти.
Граф остаётся компактным, но становится полезнее, когда заметки ссылаются друг на друга:
`[[map]]`, `[[project-overview]]`, `[[architecture]]`, `[[commands]]`, `[[tasks]]`, `[[session-summaries]]`.

Открой `AI Memory/map.md` в Obsidian, чтобы видеть компактную hub-страницу.
Для vault с несколькими проектами держи верхнеуровневую карту, которая кратко описывает каждый проект и ссылается на его карту или проектную заметку.
В репозитории теперь есть `templates/vault-map.md` как стартовый шаблон для такой vault-root заметки.
Если vault уже существует и нужен только верхний `map.md`, запусти `codex-project vault-map` из корня vault.
Если используется `--obsidian-root`, верхний `map.md` создаётся прямо в корне vault.

Когда AI генерирует код, рядом полезно создавать короткую `.md`-заметку с назначением кода, ограничениями и заметными особенностями реализации.
Если нужна такая заметка автоматически, запусти `codex-project code-note` в директории проекта. Используй `--title`, чтобы задать название заметки, и `--source`, чтобы создать её рядом с исходником. `codex-project note` это короткий алиас.
Команда заметок также создаёт верхнеуровневый `map.md`, если его ещё нет, и добавляет в заметку ссылку `[[map]]`.

## Работа С Obsidian Vault

Если хочешь хранить `AI Memory/` прямо внутри vault Obsidian, используй:

```bash
codex-project --obsidian-root "$HOME/Obsidian/MyVault"
```

Это тот же механизм symlink, что и у cloud memory, но цель — папка vault.
Так удобнее всего смотреть заметки памяти прямо в Obsidian.

Также можно использовать алиас:

```bash
codex-project --vault-root "$HOME/Obsidian/MyVault"
```

Рекомендуемые схемы:

1. Полная синхронизация vault: репозиторий лежит внутри Obsidian vault, а Remotely Save синкает весь vault.
2. Cloud AI Memory folder: `AI Memory/` — это symlink в облачную папку.
3. Только markdown-синхронизация: синкаются только memory-заметки, а `.obsidian/` остаётся локальным.

## Поддержка Remotely Save

Obsidian Remotely Save может синхронизировать vault между устройствами, но scope синхронизации нужно выбирать явно.

- Не генерируй и не коммить credentials.
- Не считай, что пользователь обязательно хочет синкать `.obsidian/`.
- Настройки провайдера Remotely Save — это приватный конфиг.
- Предпочитай markdown-only sync, если пользователь явно не хочет синкать весь vault.

Запусти helper-режим, чтобы добавить безопасную документацию:

```bash
codex-project --remotely-save
```

Он добавит заметку о безопасных схемах синка и docs-страницу `docs/remotely-save.md`, если нужно.

Практические советы:

- Если нужен одинаковый memory-контекст на нескольких устройствах, синхронизируй весь vault или используй `--obsidian-root`.
- Если нужна самая безопасная схема, держи `.obsidian/` локально и синкай только markdown-заметки.
- Никогда не храни WebDAV, S3, Dropbox или OneDrive credentials в memory-файлах.
- Считай конфиг плагина локальным секретом, если только ты явно не хочешь его синхронизировать.

## Модель Безопасности

- Не храни secrets, tokens, passwords, private keys или private URLs в memory-файлах.
- Не включай авто-запись для Remotely Save credentials.
- Спрашивай перед изменением файлов, связанных с Remotely Save, если не включён unsafe auto-write mode.
- По возможности делай изменения append-only.
- Для устойчивых фактов используй явное подтверждение.

## Правила .gitignore

Новые проекты получают безопасный блок `.gitignore` для AI memory:

- `/AI Memory/`
- `/AI Memory/**`
- `*.memory.local.md`

Блок добавляется только если нужных строк ещё нет.

## Doctor Mode

Проверяй проект перед использованием:

```bash
codex-project doctor
```

Doctor проверяет наличие `zsh`, `codex`, разрешение template root, writable directory, memory-файлы, правила Git ignore и optional cloud-root setup.

## Сравнение С claude-obsidian

`claude-obsidian` — это большой Obsidian wiki / knowledge-engine проект.
Этот репозиторий сознательно меньше.

Он фокусируется на:

- Codex-first project memory
- явной маршрутизации через `AI Memory/_index.md`
- безопасном и проверяемом создании файлов
- простом shell-workflow
- документации Remotely Save без автоматизации credentials

И сознательно избегает:

- ingest-pipeline
- автономного wiki building
- массовой генерации заметок
- сложных automation layers

## Troubleshooting

- Если `codex-project` не найден после установки, проверь `~/.local/bin` в `PATH`.
- Если template resolution не работает, укажи `CODEX_MEMORY_TEMPLATE_ROOT` на корень репозитория с `templates/AI Memory/`.
- Если `doctor` сообщает, что `AI Memory/` отслеживается Git, значит правила ignore ещё не применились.
- Если нужен общий memory-folder, создай его заранее и снова запусти с `--cloud-root`.

## Локализация

English — по умолчанию:

```bash
codex-project --lang en
```

Русские шаблоны доступны:

```bash
codex-project --lang ru
```

Можно также задать язык по умолчанию:

```bash
export CODEX_MEMORY_LANG=ru
```

## Workflow Памяти

Обычные вопросы должны использовать lookup mode:

1. Прочитай `AI Memory/_index.md`.
2. Выбери релевантные файлы памяти.
3. Читай только выбранные файлы.
4. Отвечай по активным фактам.

Сохранение явных фактов:

```text
Save to Obsidian: project run command is npm run dev.
```

или:

```text
Сохрани в Obsidian: команда запуска проекта - npm run dev.
```

Smart session save:

```text
Save
```

или:

```text
Сохрани
```

Агент должен предложить, что сохранять, проверить дубли и конфликты, а затем писать только после подтверждения.

Подтверждение на английском:

```text
Yes, save
```

Подтверждение на русском:

```text
Да, запиши
```
