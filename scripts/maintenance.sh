#!/bin/bash

# Arch Linux System Maintenance Script with -v, --help, and -a <AUR helper>
# Author: Kalpa Kuruwita

set -euo pipefail

LOG_DIR="/var/log/arch-maintenance"
LOG_FILE="$LOG_DIR/maintenance.log"
VERBOSE=false
AUR_HELPER="yay"  # default
DRY_RUN=false
ASSUME_YES=false
MODE="all"

# Help message
show_help() {
  cat << EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -v              Verbose mode (prints output to terminal and log file)
  -a <helper>     Specify AUR helper (e.g. paru, yay, or 'none' to skip)
  -m, --mode <mode>
                  Run only: update, clean, health, or all (default: all)
  -y, --yes       Run package operations noninteractively
  --dry-run       Print commands without changing the system
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
    -m|--mode)
      if [[ $# -lt 2 || -z "$2" ]]; then
        echo "❌ -m requires a mode (update, clean, health, or all)." >&2
        exit 2
      fi
      MODE="$2"
      shift 2
      ;;
    -y|--yes)
      ASSUME_YES=true
      shift
      ;;
    --dry-run)
      DRY_RUN=true
      VERBOSE=true
      shift
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

case "$MODE" in
  update|clean|health|all) ;;
  *)
    echo "❌ Unsupported mode: $MODE (use update, clean, health, or all)." >&2
    exit 2
    ;;
esac

# Ensure log directory exists
if ! $DRY_RUN; then
  sudo mkdir -p "$LOG_DIR"
  sudo chown "$(id -un)":"$(id -gn)" "$LOG_DIR"
fi

# Logging function
log() {
  if $DRY_RUN; then
    printf '%b\n' "$1"
  elif $VERBOSE; then
    printf '%b\n' "$1" | tee -a "$LOG_FILE"
  else
    printf '%b\n' "$1" >> "$LOG_FILE"
  fi
}

run_logged() {
  if $DRY_RUN; then
    printf '[dry-run]'
    printf ' %q' "$@"
    printf '\n'
  elif $VERBOSE; then
    "$@" 2>&1 | tee -a "$LOG_FILE"
  else
    "$@" >> "$LOG_FILE" 2>&1
  fi
}

mode_enabled() {
  [[ "$MODE" == "all" || "$MODE" == "$1" ]]
}

confirm_args=()
if $ASSUME_YES; then
  confirm_args=(--noconfirm)
fi

log "\n🕒 $(date): Starting Arch Linux system maintenance..."

HEALTH_ISSUES=false

if mode_enabled update; then
  log "📦 Updating system packages..."
  run_logged sudo pacman -Syu "${confirm_args[@]}"

  if [[ "$AUR_HELPER" == "none" ]]; then
    log "🚫 Skipping AUR package updates."
  elif command -v "$AUR_HELPER" &> /dev/null || $DRY_RUN; then
    log "📦 Updating AUR packages with '$AUR_HELPER'..."
    run_logged "$AUR_HELPER" -Syu "${confirm_args[@]}"
  else
    log "⚠️ AUR helper '$AUR_HELPER' not found. Skipping AUR updates."
  fi

  if command -v reflector &> /dev/null || $DRY_RUN; then
    log "🌐 Updating mirrorlist..."
    run_logged sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
  else
    log "⚠️ 'reflector' not found. Skipping mirrorlist update."
  fi
fi

if mode_enabled clean; then
  log "🧹 Cleaning package cache..."
  run_logged sudo paccache -r

  log "🗑️ Removing orphaned packages..."
  if $DRY_RUN; then
    run_logged pacman -Qtdq
    log "[dry-run] Orphans, if present, would be removed with pacman -Rns."
  else
    mapfile -t orphans < <(pacman -Qtdq || true)
    if [[ ${#orphans[@]} -gt 0 ]]; then
      run_logged sudo pacman -Rns "${confirm_args[@]}" "${orphans[@]}"
    else
      log "✅ No orphaned packages found."
    fi
  fi

  log "🧾 Cleaning journal logs..."
  run_logged sudo journalctl --vacuum-time=2weeks
  run_logged sudo journalctl --vacuum-size=100M

  if command -v flatpak &> /dev/null || $DRY_RUN; then
    log "🧹 Removing unused Flatpak packages..."
    if $ASSUME_YES; then
      run_logged flatpak uninstall --unused -y
    else
      run_logged flatpak uninstall --unused
    fi
  else
    log "ℹ️ Flatpak not installed. Skipping Flatpak cleanup."
  fi
fi

if mode_enabled health; then
  log "🩺 Checking system health..."
  if ! run_logged systemctl --failed; then
    log "⚠️ systemd reports failed units; see the log for details."
    HEALTH_ISSUES=true
  fi
  if ! run_logged sudo pacman -Qk; then
    log "⚠️ Package integrity checks reported problems; see the log for details."
    HEALTH_ISSUES=true
  fi
fi

if $HEALTH_ISSUES; then
  log "⚠️ Done with health warnings at $(date)."
else
  log "✅ Done: Maintenance completed at $(date)."
fi
