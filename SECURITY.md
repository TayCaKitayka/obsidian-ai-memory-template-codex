# Security Policy

## What not to store

- Secrets
- Tokens
- API keys
- WebDAV passwords
- S3 credentials
- Dropbox tokens
- OneDrive tokens
- Remotely Save private config
- Private keys

Do not write these into `AI Memory/`, `AGENTS.md`, `AGENTS.override.md`, or generated docs.

## Remotely Save

Remotely Save provider settings may contain sensitive credentials.
This repository only documents safe layouts and does not generate credential files.

## Reporting a security issue

If you find a security issue in this scaffold, report it privately to the repository owner or maintainers.
Do not publish secrets, tokens, or private configuration in an issue or pull request.
