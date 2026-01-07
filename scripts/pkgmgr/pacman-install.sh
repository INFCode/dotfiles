#!/usr/bin/env bash
set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/common.sh
. "${SCRIPT_DIR}/../lib/common.sh"

function pacman_install() {
  if [[ $# -eq 0 ]]; then
    die "usage: $(basename "$0") <package-name>..."
  fi

  info "installing packages via pacman: $*"
  sudo pacman -S --noconfirm --needed "$@" || die "failed to install packages: $*"
  info "ok: packages installed"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  pacman_install "$@"
fi

