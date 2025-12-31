#!/usr/bin/env bash
set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/common.sh
. "${SCRIPT_DIR}/../lib/common.sh"

function install_tool() {
  if is_tool_exists paru; then
    info "ok: paru already installed"
    return 0
  fi

  # Dependencies (pacman, sudo, git, makepkg) are checked in deps/ scripts

  local tmp
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT

  git -C "$tmp" clone --depth 1 https://aur.archlinux.org/paru-bin.git
  (
    cd "$tmp/paru-bin"
    makepkg -si --noconfirm --needed
  )

  is_tool_exists paru || die "paru install completed but paru is still not on PATH"
  info "ok: paru installed"
}

function main() {
  install_tool
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main
fi
