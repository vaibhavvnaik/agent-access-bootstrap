# Agent Access Bootstrap

Reusable WSL onboarding toolkit for coding agents (Codex, Claude Code, etc.) to set up and verify access to:
- Vercel
- Railway
- Google Cloud
- Backblaze B2
- MongoDB Atlas

## Quick start

```bash
bash onboarding/agent-access-bootstrap.sh all
```

For details, see `onboarding/README.md`.

## Skill package

Reusable skill for agents:

- `skills/wsl-agent-access/SKILL.md`

## Extending to new providers

Add executable scripts in:

- `onboarding/providers.d/`

Start from:

- `onboarding/providers.d/template-provider.sh`
