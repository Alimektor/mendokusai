#!/usr/bin/env bash

install_bats_library() {
    local library_name=${1}
    local library_url=${2}
    local library_path="${HOME}/.bats/libs/${library_name}"

    if [[ -d "${library_path}" ]]; then
        echo "Library ${library_name} already installed"
        return
    fi

    git clone "${library_url}" "${library_path}"
}

echo "Installing bats libraries"
install_bats_library "bats-support" "https://github.com/bats-core/bats-support.git"
install_bats_library "bats-assert" "https://github.com/bats-core/bats-assert.git"
install_bats_library "bats-file" "https://github.com/bats-core/bats-file.git"
install_bats_library "bats-alimektor" "https://github.com/alimektor/bats-alimektor.git"
