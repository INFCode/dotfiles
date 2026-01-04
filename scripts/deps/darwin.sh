#!/usr/bin/env bash
set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/common.sh
. "${SCRIPT_DIR}/../lib/common.sh"

function main() {
  require_tools bash xcode-select

  # xcode-select may need to be installed even if it's already in PATH
  # Try xcode-select -p because it succeeds only after Xcode CLI tools are installed.
  # It requires GUI interaction so this cannot be automated.
  if ! xcode-select -p &>/dev/null; then
    die "xcode-select is not installed, run `xcode-select --install` to install it"
  fi

  info "ok: darwin-specific dependencies present"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main
fi


