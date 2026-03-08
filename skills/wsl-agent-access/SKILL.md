---
name: wsl-agent-access
description: Use this skill when setting up, restoring, or extending local auth access in WSL for coding agents across repositories. Handles Vercel, Railway, Google Cloud, Backblaze B2, MongoDB Atlas, and future providers via plug-in hooks.
---

# WSL Agent Access

## When to use

Use this skill when:
- a new WSL environment is created
- auth is broken/missing after reinstall
- you need to onboard Codex/Claude/other coding agents to same third-party accounts
- you need one reusable process that works across multiple repositories in the same IDE/workspace
- you want to add a new provider without rewriting the bootstrap core

## Canonical workflow

From repo root, run one command:

```bash
bash onboarding/agent-access-bootstrap.sh all
```

If auth state was previously backed up (for example before WSL reset), restore first:

```bash
bash onboarding/agent-access-bootstrap.sh restore ~/agent-access-auth-state.tgz
```

## Fine-grained commands

```bash
bash onboarding/agent-access-bootstrap.sh install
bash onboarding/agent-access-bootstrap.sh login
bash onboarding/agent-access-bootstrap.sh verify
bash onboarding/agent-access-bootstrap.sh backup ~/agent-access-auth-state.tgz
```

## Extensibility contract

Provider plug-ins live in:

- `onboarding/providers.d/*.sh`

Each provider script receives one phase argument:

- `install`
- `login`
- `verify`
- `backup-paths`
- `restore`

Use `onboarding/providers.d/template-provider.sh` as your starting point.
For full extension details, read:

- `skills/wsl-agent-access/references/extensions.md`

Built-in extension:
- `onboarding/providers.d/vercel-agent-browser-skills.sh`
  - installs `agent-browser`
  - installs Chromium with `agent-browser install`
  - installs Vercel skill packs: `agent-browser`, `dogfood`, `electron`, `slack`

## Account mapping

- `vaibhav.ideator@gmail.com`: Vercel, Railway, Backblaze, Google Cloud
- `ncgcompany2023@gmail.com`: MongoDB Atlas

## Notes

- Login is interactive and may require browser/device-code confirmation.
- Backup archives contain credentials; treat as sensitive.
- This skill is intentionally script-first so any agent can run the same deterministic workflow.
