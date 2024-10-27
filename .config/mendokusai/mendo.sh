#!/usr/bin/env bash

mendo() {
    /usr/bin/git --git-dir="${HOME}/.config/mendokusai/git" --work-tree="${HOME}" "${@}"
}
