#!/usr/bin/env bash
set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/common.sh
. "${SCRIPT_DIR}/../lib/common.sh"

function main() {
  require_tools pacman sudo makepkg

  info "ok: arch-specific dependencies present"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main
fi


