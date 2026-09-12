#!/usr/bin/env bash

set -euo pipefail

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

while read -r _ _ _ submodule_path; do
  if ! git -C "$REPO_DIR" config -f .gitmodules --get-regexp '^submodule\..*\.path$' \
    | awk '{ print $2 }' | grep -Fqx "$submodule_path"; then
    echo "Missing .gitmodules entry for $submodule_path" >&2
    exit 1
  fi
done < <(git -C "$REPO_DIR" ls-files --stage | awk '$1 == "160000"')

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

echo "Smoke tests passed."
