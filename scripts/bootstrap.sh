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

clone_repo "soonio-api" "git@github.com:soonio-org/soonio-api.git"
clone_repo "soonio-ext" "git@github.com:soonio-org/soonio-ext.git"
clone_repo "soonio-web" "https://github.com/soonio-org/soonio-web.git"
