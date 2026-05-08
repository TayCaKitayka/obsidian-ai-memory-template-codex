# Contributing

Keep changes small, reviewable, and safe.

## Local checks

```bash
zsh -n install.sh
zsh -n bin/codex-project
zsh -n scripts/smoke-test.zsh
./scripts/smoke-test.zsh
```

## Notes

- Do not add secrets, tokens, or private plugin config to AI Memory files.
- Keep new functionality Codex-first and shell-friendly.
- Preserve the Russian localization when touching shared templates.
