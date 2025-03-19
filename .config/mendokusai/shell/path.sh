#!/usr/bin/env bash
# Customize PATH variable.

# Add local path to the global path.
pathadd() {
    local _path="${1}"
    if [[ -d "${_path}" ]] && [[ ":${PATH}:" != *":${_path}:"* ]]; then
        export PATH="${PATH:+"${PATH}:"}${_path}"
    fi
}

# Add ~/.local/bin to the PATH variable.
pathadd "${HOME}/.local/bin"

# Add ~/bin to the PATH variable.
pathadd "${HOME}/bin"

# Add Go binaries to the PATH variable.
pathadd "${HOME}/go/bin"

# Add Rust binaries and environment to the PATH variable.
pathadd "${HOME}/.cargo/bin"
pathadd "${HOME}/.cargo/env"

# Add Snap binaries to the PATH variable.
pathadd "/var/lib/snapd/snap/bin"

# Add Flutter binaries to the PATH variable.
pathadd "${HOME}/flutter/bin"
