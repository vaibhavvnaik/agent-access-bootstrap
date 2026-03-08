# Onboarding and Access Agent

This folder now contains a repeatable bootstrap flow you can rerun on a fresh WSL environment.

## One-command setup

From repo root:

```bash
bash onboarding/agent-access-bootstrap.sh all
```

This runs:
- `install`: installs/updates CLIs and persistent PATH
- `login`: interactive auth for Vercel, Railway, GCloud, Backblaze, Atlas
- `verify`: confirms install + auth status
- includes Agent Browser + Vercel skill packs (`agent-browser`, `dogfood`, `electron`, `slack`)

## Individual commands

```bash
bash onboarding/agent-access-bootstrap.sh install
bash onboarding/agent-access-bootstrap.sh login
bash onboarding/agent-access-bootstrap.sh verify
```

## Extend with new tools/providers

Add executable provider scripts under `onboarding/providers.d/`.

- Start from `onboarding/providers.d/template-provider.sh`
- Implement phases: `install`, `login`, `verify`, `backup-paths`, `restore`
- The orchestrator auto-runs these hooks during `install/login/verify/backup/restore`

This keeps the core bootstrap stable while allowing future providers to plug in.

Built-in provider hook:
- `onboarding/providers.d/vercel-agent-browser-skills.sh`
  - installs `agent-browser`
  - runs `agent-browser install` (Chromium download)
  - installs Vercel skills globally with `npx skills add ... -y -g`

## Backup and restore auth state

Create a local backup file:

```bash
bash onboarding/agent-access-bootstrap.sh backup ~/agent-access-auth-state.tgz
```

Restore after WSL reset:

```bash
bash onboarding/agent-access-bootstrap.sh restore ~/agent-access-auth-state.tgz
```

## Accounts mapping

- `vaibhav.ideator@gmail.com`: Vercel, Railway, Backblaze, Google Cloud
- `ncgcompany2023@gmail.com`: MongoDB Atlas

## Security notes

- Backup archives include tokens/credentials. Keep them encrypted and private.
- GitHub Secrets are write-only; rotate keys if exposure is suspected.
