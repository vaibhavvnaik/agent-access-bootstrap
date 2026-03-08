#!/usr/bin/env bash
set -euo pipefail

phase="${1:-}"

ensure_agent_symlinks() {
  local base="${HOME}/.agents/skills"
  local target

  mkdir -p "$base"
  for target in "${HOME}/.claude/skills" "${HOME}/.claude-code/skills" "${HOME}/.claude-cowork/skills"; do
    mkdir -p "$(dirname "$target")"
    if [ -L "$target" ]; then
      continue
    fi
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      # Preserve user files; just mirror core skills into existing directory.
      ln -sfn "${base}/agent-browser" "${target}/agent-browser" 2>/dev/null || true
      ln -sfn "${base}/dogfood" "${target}/dogfood" 2>/dev/null || true
      ln -sfn "${base}/electron" "${target}/electron" 2>/dev/null || true
      ln -sfn "${base}/slack" "${target}/slack" 2>/dev/null || true
      continue
    fi
    ln -sfn "$base" "$target"
  done
}

install_phase() {
  npm install -g agent-browser

  # Download Chromium runtime. Fallback with deps hint if needed on Linux.
  if ! agent-browser install; then
    echo "[agent-access][warn] agent-browser install failed; trying --with-deps"
    agent-browser install --with-deps || true
  fi

  npx skills add vercel-labs/agent-browser --skill agent-browser -y -g
  npx skills add vercel-labs/agent-browser --skill dogfood -y -g
  npx skills add vercel-labs/agent-browser --skill electron -y -g
  npx skills add vercel-labs/agent-browser --skill slack -y -g

  ensure_agent_symlinks
}

verify_phase() {
  if command -v agent-browser >/dev/null 2>&1; then
    echo "[ok] agent-browser installed"
  else
    echo "[missing] agent-browser installed"
  fi

  local list
  list="$(npx skills list -g 2>/dev/null || true)"

  for skill in agent-browser dogfood electron slack; do
    if printf '%s\n' "$list" | grep -q "${skill}"; then
      echo "[ok] skills ${skill}"
    else
      echo "[missing] skills ${skill}"
    fi
  done

  if [ -e "${HOME}/.claude/skills/agent-browser" ] || [ -L "${HOME}/.claude/skills" ]; then
    echo "[ok] claude skills link"
  else
    echo "[missing] claude skills link"
  fi
}

case "$phase" in
  install)
    install_phase
    ;;
  verify)
    verify_phase
    ;;
  login|backup-paths|restore)
    ;;
  *)
    ;;
esac
