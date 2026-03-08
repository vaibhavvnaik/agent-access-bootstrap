# Extension Guide

Use this when adding a new provider/tool to onboarding.

## File layout

- `onboarding/providers.d/<provider>.sh` (executable)
- Built-in example: `onboarding/providers.d/vercel-agent-browser-skills.sh`

## Hook phases

The orchestrator invokes provider scripts with one argument:

- `install`: install CLI/dependencies
- `login`: interactive login/auth flow
- `verify`: print status lines (`[ok] ...` or `[missing] ...`)
- `backup-paths`: print relative `$HOME` paths to include in auth-state backup
- `restore`: optional post-restore initialization

## Minimal pattern

```bash
#!/usr/bin/env bash
set -euo pipefail
phase="${1:-}"

case "$phase" in
  install)
    ;;
  login)
    ;;
  verify)
    ;;
  backup-paths)
    ;;
  restore)
    ;;
  *)
    ;;
esac
```

## Validation

1. `bash onboarding/agent-access-bootstrap.sh install`
2. `bash onboarding/agent-access-bootstrap.sh login`
3. `bash onboarding/agent-access-bootstrap.sh verify`
4. `bash onboarding/agent-access-bootstrap.sh backup ~/agent-access-auth-state.tgz`
5. `bash onboarding/agent-access-bootstrap.sh restore ~/agent-access-auth-state.tgz`
