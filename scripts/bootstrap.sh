#!/usr/bin/env bash

set -euo pipefail

workspace_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
repos_dir="$workspace_dir/repos"

clone_repo() {
  local name="$1"
  local url="$2"
  local target="$repos_dir/$name"

  if [[ -e "$target" ]]; then
    printf 'Keeping existing repository: %s\n' "$target"
    return
  fi

  git clone "$url" "$target"
}

mkdir -p "$repos_dir"

clone_repo "anyrem-desktop" "git@github.com:anyrem-org/anyrem-desktop.git"
clone_repo "anyrem-be" "git@github.com:anyrem-org/anyrem-be.git"
clone_repo "anyrem-mcp" "https://github.com/anyrem-org/anyrem-mcp.git"
clone_repo "anyrem-infra" "https://github.com/anyrem-org/anyrem-infra.git"
