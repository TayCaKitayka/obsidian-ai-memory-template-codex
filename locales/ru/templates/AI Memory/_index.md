# Индекс AI Memory

Этот файл является картой маршрутизации для AI-памяти.
Агент должен читать этот файл перед выбором memory-файлов.

## Файлы

### profile.md

- Title: Профиль
- Description: Базовый профиль пользователя и устойчивый личный контекст.
- Categories: profile, identity, workstyle
- Aliases: профиль, личность, работа, кто я
- Priority: high
- Last updated: YYYY-MM-DD

### preferences.md

- Title: Предпочтения
- Description: Предпочтения пользователя по коммуникации, форматированию и инструментам.
- Categories: preferences, communication, style
- Aliases: стиль, предпочтения, язык, формат
- Priority: high
- Last updated: YYYY-MM-DD

### hardware.md

- Title: Железо
- Description: Устройства пользователя, компьютеры, серверы, операционные системы и характеристики.
- Categories: hardware, devices, os
- Aliases: компьютер, сервер, ноутбук, телефон, железо
- Priority: high
- Last updated: YYYY-MM-DD

### software.md

- Title: Софт
- Description: Операционные системы, программы, сервисы, настройки и окружения.
- Categories: software, apps, services, configuration
- Aliases: софт, приложения, docker, vpn, terminal, shell
- Priority: medium
- Last updated: YYYY-MM-DD

### projects.md

- Title: Проекты
- Description: Проекты пользователя, цели, планы, архитектуры и идеи.
- Categories: projects, goals, plans, architecture
- Aliases: проект, задача, идея, план
- Priority: medium
- Last updated: YYYY-MM-DD

### people.md

- Title: Люди
- Description: Люди, контакты, команды и организации.
- Categories: people, contacts
- Aliases: люди, контакты, команда
- Priority: low
- Last updated: YYYY-MM-DD

### decisions.md

- Title: Решения
- Description: Решения, причины, отклонённые альтернативы и история выбора.
- Categories: decisions, history, reasoning
- Aliases: решение, причина, выбрал, отказался
- Priority: medium
- Last updated: YYYY-MM-DD

### _inbox.md

- Title: Входящие
- Description: Временное место для неясных, несортированных или конфликтующих фактов.
- Categories: inbox, unsorted, unclear
- Aliases: inbox, входящие, неясное, несортированное
- Priority: low
- Last updated: YYYY-MM-DD

## Файлы памяти проекта

Используй этот раздел для задач по коду и проекту. Сначала читай `AI Memory/_index.md`, затем только релевантные project-memory файлы.

### project-overview.md

- Title: Обзор проекта
- Description: Назначение проекта, границы, цели, устойчивый контекст и текущий статус.
- Read when: нужно понять, что это за проект, зачем он нужен и что входит в scope.
- Categories: project, overview, scope, goals
- Aliases: обзор проекта, цель проекта, scope, контекст проекта
- Priority: high
- Last updated: YYYY-MM-DD

### architecture.md

- Title: Архитектура
- Description: Архитектура проекта, компоненты, связи, ограничения и технические решения.
- Read when: задача касается архитектуры, структуры, компонентов, потоков данных или технических tradeoff.
- Categories: architecture, design, components, system
- Aliases: архитектура, дизайн, структура, компоненты
- Priority: high
- Last updated: YYYY-MM-DD

### dev-environment.md

- Title: Окружение разработки
- Description: Локальное окружение разработки, зависимости, требования и настройка.
- Read when: задача касается установки, окружения, зависимостей, PATH, shell, локального запуска или setup.
- Categories: development, environment, setup, dependencies
- Aliases: окружение, setup, установка, зависимости, PATH
- Priority: high
- Last updated: YYYY-MM-DD

### commands.md

- Title: Команды
- Description: Проверенные команды запуска, тестов, линтинга, сборки, проверки и обслуживания.
- Read when: нужно запустить, проверить, протестировать, собрать или диагностировать проект.
- Categories: commands, run, test, lint, build
- Aliases: команды, запуск, тесты, проверка, build, lint
- Priority: high
- Last updated: YYYY-MM-DD

### conventions.md

- Title: Соглашения
- Description: Соглашения проекта: стиль, структура файлов, именование и рабочие правила.
- Read when: задача касается редактирования файлов, форматирования, структуры, naming или repository conventions.
- Categories: conventions, style, naming, repository
- Aliases: соглашения, стиль, правила, naming, структура
- Priority: medium
- Last updated: YYYY-MM-DD

### known-issues.md

- Title: Известные проблемы
- Description: Известные баги, ограничения, обходные пути, риски и troubleshooting-контекст.
- Read when: задача касается ошибок, диагностики, troubleshooting, ограничений или регрессий.
- Categories: bugs, issues, limitations, troubleshooting
- Aliases: баги, проблемы, ограничения, troubleshooting, риски
- Priority: medium
- Last updated: YYYY-MM-DD

### tasks.md

- Title: Задачи
- Description: Устойчивые задачи, планы, открытые вопросы и будущие улучшения.
- Read when: задача касается планирования, roadmap, TODO, follow-up или приоритизации.
- Categories: tasks, roadmap, todo, planning
- Aliases: задачи, планы, todo, roadmap, follow-up
- Priority: medium
- Last updated: YYYY-MM-DD

### session-summaries.md

- Title: Итоги сессий
- Description: Краткие итоги существенных AI coding sessions для сохранения контекста.
- Read when: нужно восстановить предыдущую работу, понять последние изменения или продолжить прошлую сессию.
- Categories: sessions, summaries, history, continuity
- Aliases: сессии, итоги, история, summary, продолжение
- Priority: medium
- Last updated: YYYY-MM-DD
