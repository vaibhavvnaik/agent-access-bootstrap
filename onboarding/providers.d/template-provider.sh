#!/usr/bin/env bash
set -euo pipefail

# Copy this file to onboarding/providers.d/<your-provider>.sh and implement hooks.
# Contract:
#   <script> install      -> install CLI/deps
#   <script> login        -> run interactive auth/login
#   <script> verify       -> print [ok]/[missing] checks
#   <script> backup-paths -> print relative paths (from $HOME) to include in backup tar
#   <script> restore      -> optional post-restore actions

phase="${1:-}"

case "$phase" in
  install)
    # Example: npm install -g your-cli
    ;;
  login)
    # Example: your-cli auth login
    ;;
  verify)
    # Example:
    # if your-cli whoami >/dev/null 2>&1; then
    #   echo "[ok] your-provider auth"
    # else
    #   echo "[missing] your-provider auth"
    # fi
    ;;
  backup-paths)
    # Example: echo ".config/your-cli"
    ;;
  restore)
    # Optional: run migration/refresh after state restore
    ;;
  *)
    # No-op for unsupported phases
    ;;
esac
