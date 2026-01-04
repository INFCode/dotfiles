#!/usr/bin/env bash
set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/common.sh
. "${SCRIPT_DIR}/../lib/common.sh"

function install_tool() {
  if is_tool_exists brew; then
    info "ok: brew already installed"
    return 0
  fi

  confirm_operation "Homebrew not found, install it now?"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  is_tool_exists brew || die "brew install script completed but brew is still not on PATH"
  info "ok: brew installed"
}

function main() {
  install_tool
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main
fi
