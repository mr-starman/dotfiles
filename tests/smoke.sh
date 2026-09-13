#!/usr/bin/env bash

set -euo pipefail

FORCE_JAVASCRIPT_ACTIONS_TO_NODE24=true

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_HOME="$(mktemp -d)"
trap 'rm -rf -- "$TEST_HOME"' EXIT

scripts=(
  "$REPO_DIR/install.sh"
  "$REPO_DIR/scripts/maintenance.sh"
  "$REPO_DIR/scripts/listify"
  "$REPO_DIR/scripts/listifyq"
  "$REPO_DIR/bash/bashrc"
  "$REPO_DIR/bash/bash_aliases"
  "$REPO_DIR/bash/bash_profile"
  "$REPO_DIR/bash/bash_logout"
)

bash -n "${scripts[@]}"
if command -v shellcheck >/dev/null; then
  shellcheck "${scripts[@]}"
fi

json_files=(
  "$REPO_DIR/opencode/package.json"
  "$REPO_DIR/opencode/package-lock.json"
  "$REPO_DIR/vscode/user/settings.json"
  "$REPO_DIR/vscode/user/keybindings.json"
)
if command -v jq >/dev/null; then
  jq empty "${json_files[@]}"
fi

if command -v luac >/dev/null; then
  while IFS= read -r -d '' lua_file; do
    luac -p "$lua_file"
  done < <(find "$REPO_DIR/nvim" -type f -name '*.lua' -print0)
fi

if git -C "$REPO_DIR" ls-files --stage | awk '$1 == "160000" { found = 1 } END { exit !found }'; then
  echo "Unexpected Git submodule found; plugins should be managed by their plugin manager" >&2
  exit 1
fi

HOME="$TEST_HOME" "$REPO_DIR/install.sh" --dry-run --skip-bootstrap >/dev/null
if find "$TEST_HOME" -mindepth 1 -print -quit | grep -q .; then
  echo "dry-run modified HOME" >&2
  exit 1
fi

printf 'original\n' >"$TEST_HOME/.bashrc"
HOME="$TEST_HOME" "$REPO_DIR/install.sh" --skip-bootstrap >/dev/null
test -L "$TEST_HOME/.bashrc"
test "$(readlink -- "$TEST_HOME/.bashrc")" = "$REPO_DIR/bash/bashrc"
compgen -G "$TEST_HOME/.bashrc.backup.*" >/dev/null

if HOME="$TEST_HOME" "$REPO_DIR/scripts/maintenance.sh" -a >/dev/null 2>&1; then
  echo "maintenance.sh accepted a missing -a value" >&2
  exit 1
fi
if HOME="$TEST_HOME" "$REPO_DIR/scripts/maintenance.sh" -a invalid >/dev/null 2>&1; then
  echo "maintenance.sh accepted an unsupported AUR helper" >&2
  exit 1
fi

maintenance_preview="$(HOME="$TEST_HOME" "$REPO_DIR/scripts/maintenance.sh" --dry-run -a none)"
if grep -q -- '--noconfirm' <<<"$maintenance_preview"; then
  echo "maintenance dry-run enabled noninteractive package operations by default" >&2
  exit 1
fi
grep -q 'pacman -Syu' <<<"$maintenance_preview"
grep -q 'paccache -r' <<<"$maintenance_preview"
grep -q 'pacman -Rns' <<<"$maintenance_preview"
grep -q 'pacman -Qk' <<<"$maintenance_preview"

confirmed_preview="$(HOME="$TEST_HOME" "$REPO_DIR/scripts/maintenance.sh" --dry-run --yes -m update -a none)"
grep -q -- '--noconfirm' <<<"$confirmed_preview"
health_preview="$(HOME="$TEST_HOME" "$REPO_DIR/scripts/maintenance.sh" --dry-run --mode health -a none)"
grep -q 'pacman -Qk' <<<"$health_preview"

CLONE_DIR="$TEST_HOME/fresh-clone"
git clone -q "$REPO_DIR" "$CLONE_DIR"
FRESH_HOME="$TEST_HOME/fresh-home"
mkdir -p "$FRESH_HOME"
HOME="$FRESH_HOME" "$CLONE_DIR/install.sh" --dry-run --skip-bootstrap >/dev/null
if find "$FRESH_HOME" -mindepth 1 -print -quit | grep -q .; then
  echo "fresh-clone dry-run modified HOME" >&2
  exit 1
fi

echo "Smoke tests passed."
