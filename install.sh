#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--dry-run|-n]

Link the repository-managed configuration into ~/.config.

Options:
  -n, --dry-run  Show planned backups and symlinks without changing anything.
  -h, --help     Show this help.
USAGE
}

dry_run=0
while (($#)); do
  case "$1" in
    -n|--dry-run)
      dry_run=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source_root="$repo_root/config"
config_root="${HOME:?}/.config"
backup_root="${HOME:?}/.local/state/tuge-omarchy/backups/$(date -u +%Y%m%dT%H%M%S%N)"

# Every entry is mirrored under config/ and linked to the same relative path
# below ~/.config. Keep this list explicit so browser profiles and runtime state
# can never be imported accidentally.
managed_paths=(
  'hypr'
  'omarchy/shell.json'
  'omarchy/shell.toml'
  'omarchy/extensions'
  'omarchy/hooks'
  'omarchy/plugins'
  'omarchy/themes'
  'alacritty'
  'foot'
  'kitty'
  'ghostty'
  'btop'
  'lazygit'
  'nvim'
  'tmux'
  'opencode'
  'herdr'
  'starship.toml'
  'mimeapps.list'
  'xdg-terminals.list'
)

printf 'Repository: %s\n' "$repo_root"
printf 'Mode:       %s\n' "$([[ $dry_run -eq 1 ]] && printf 'dry-run' || printf 'install')"

# Validate every source before changing any destination.
for rel in "${managed_paths[@]}"; do
  source="$source_root/$rel"
  if [[ ! -e "$source" && ! -L "$source" ]]; then
    printf 'Missing repository source: %s\n' "$source" >&2
    exit 1
  fi
done

for rel in "${managed_paths[@]}"; do
  source="$source_root/$rel"
  target="$config_root/$rel"
  desired=$(readlink -f -- "$source")

  if [[ -L "$target" ]]; then
    current=$(readlink -f -- "$target" 2>/dev/null || true)
    if [[ "$current" == "$desired" ]]; then
      printf '[skip]  %s already links to repository\n' "$target"
      continue
    fi
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup="$backup_root/.config/$rel"
    printf '[backup] %s -> %s\n' "$target" "$backup"
    if ((dry_run == 0)); then
      mkdir -p -- "$(dirname -- "$backup")"
      mv -- "$target" "$backup"
    fi
  fi

  printf '[link]   %s -> %s\n' "$target" "$source"
  if ((dry_run == 0)); then
    mkdir -p -- "$(dirname -- "$target")"
    ln -s -- "$source" "$target"
  fi
done

if ((dry_run == 1)); then
  printf 'Dry run complete. No files, backups, or symlinks were changed.\n'
else
  printf 'Installation complete. Backups: %s\n' "$backup_root"
fi
