#!/usr/bin/env bash
# めんどくさい is a public home (~) config directory with useful configs, scripts, cheat codes, shell libraries for Linux / Git Bash for every day.

mendo() {
    git --git-dir="${HOME}/.config/mendokusai/git" --work-tree="${HOME}" "${@}"
}

# Customize PATH
[[ -r "${HOME}/.config/mendokusai/path.sh" ]] && . "${HOME}/.config/mendokusai/path.sh"
