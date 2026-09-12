#!/bin/bash

# Arch Linux System Maintenance Script with -v, --help, and -a <AUR helper>
# Author: Kalpa Kuruwita

set -euo pipefail

LOG_DIR="/var/log/arch-maintenance"
LOG_FILE="$LOG_DIR/maintenance.log"
VERBOSE=false
AUR_HELPER="yay"  # default

# Help message
show_help() {
  cat << EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -v              Verbose mode (prints output to terminal and log file)
  -a <helper>     Specify AUR helper (e.g. paru, yay, or 'none' to skip)
  --help          Display this help message

This script performs routine Arch Linux system maintenance tasks:
  - System + AUR updates
  - Package and journal cleanup
  - Orphaned package removal
  - Mirrorlist update (requires 'reflector')
  - Flatpak cleanup (if installed)
EOF
  exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -v)
      VERBOSE=true
      shift
      ;;
    -a)
      if [[ $# -lt 2 || -z "$2" ]]; then
        echo "❌ -a requires an AUR helper (paru, yay, or none)." >&2
        exit 2
      fi
      AUR_HELPER="$2"
      shift 2
      ;;
    --help)
      show_help
      ;;
    *)
      echo "❌ Unknown option: $1. Use --help for usage."
      exit 1
      ;;
  esac
done

case "$AUR_HELPER" in
  paru|yay|none) ;;
  *)
    echo "❌ Unsupported AUR helper: $AUR_HELPER (use paru, yay, or none)." >&2
    exit 2
    ;;
esac

# Ensure log directory exists
sudo mkdir -p "$LOG_DIR"
sudo chown "$USER":"$USER" "$LOG_DIR"

# Logging function
log() {
  if $VERBOSE; then
    echo -e "$1" | tee -a "$LOG_FILE"
  else
    echo -e "$1" >> "$LOG_FILE"
  fi
}

run_logged() {
  if $VERBOSE; then
    "$@" 2>&1 | tee -a "$LOG_FILE"
  else
    "$@" >> "$LOG_FILE" 2>&1
  fi
}

log "\n🕒 $(date): Starting Arch Linux system maintenance..."

log "📦 Updating system packages..."
run_logged sudo pacman -Syu --noconfirm

log "🧹 Cleaning package cache..."
run_logged sudo paccache -r

log "🗑️ Removing orphaned packages..."
mapfile -t orphans < <(pacman -Qtdq || true)
if [[ ${#orphans[@]} -gt 0 ]]; then
  run_logged sudo pacman -Rns --noconfirm "${orphans[@]}"
else
  log "✅ No orphaned packages found."
fi

# AUR update logic
if [[ "$AUR_HELPER" == "none" ]]; then
  log "🚫 Skipping AUR package updates."
elif command -v "$AUR_HELPER" &> /dev/null; then
  log "📦 Updating AUR packages with '$AUR_HELPER'..."
  run_logged "$AUR_HELPER" -Syu --noconfirm
else
  log "⚠️ AUR helper '$AUR_HELPER' not found. Skipping AUR updates."
fi

log "🧾 Cleaning journal logs..."
run_logged sudo journalctl --vacuum-time=2weeks
run_logged sudo journalctl --vacuum-size=100M

log "🩺 Checking system health..."
HEALTH_ISSUES=false
if ! run_logged systemctl --failed; then
  log "⚠️ systemd reports failed units; see the log for details."
  HEALTH_ISSUES=true
fi
if ! run_logged sudo pacman -Qk; then
  log "⚠️ Package integrity checks reported problems; see the log for details."
  HEALTH_ISSUES=true
fi

if command -v reflector &> /dev/null; then
  log "🌐 Updating mirrorlist..."
  run_logged sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
else
  log "⚠️ 'reflector' not found. Skipping mirrorlist update."
fi

if command -v flatpak &> /dev/null; then
  log "🧹 Removing unused Flatpak packages..."
  run_logged flatpak uninstall --unused -y
else
  log "ℹ️ Flatpak not installed. Skipping Flatpak cleanup."
fi

if $HEALTH_ISSUES; then
  log "⚠️ Done with health warnings at $(date)."
else
  log "✅ Done: Maintenance completed at $(date)."
fi
