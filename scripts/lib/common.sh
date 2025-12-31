#!/usr/bin/env bash

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

setup_colors

function die() {
  printf "${RED}error: %s${NOFORMAT}\n" "$*" >&2
  exit 1
}

function info() {
  printf "${GREEN}=> %s${NOFORMAT}\n" "$*" >&2
}

function warn() {
  printf "${YELLOW}warning: %s${NOFORMAT}\n" "$*" >&2
}

function is_tool_exists() {
  command -v "$1" &>/dev/null
}

function require_tool() {
  is_tool_exists "$1" || die "missing required command: $1"
}

function require_tools() {
  for tool in "$@"; do
    require_tool "$tool"
  done
}
