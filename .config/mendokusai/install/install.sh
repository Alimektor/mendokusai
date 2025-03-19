#!/usr/bin/env -S bash -e
# Install Mendokusai for the current user.

# Determine script path
SCRIPT_PATH="${BASH_SOURCE[0]}"
while [[ -L "${SCRIPT_PATH}" ]]; do
    SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
    SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
    [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
SCRIPT_BASENAME=${SCRIPT_PATH##*/}

# shellcheck disable=SC1091
. "${SCRIPT_DIR}/../lib/functions.sh"

main() {
    mendokusai_os_name=$(
        set -e
        get_os
        true
    )
    print_info "Installing Mendokusai (using ${SCRIPT_BASENAME}) for the current user..."
    git clone --bare https://github.com/Alimektor/mendokusai.git "${HOME}/.config/mendokusai-git/"

    print_info "Configuring Mendokusai..."
    mendo() { git --git-dir="${HOME}/.config/mendokusai-git" --work-tree="${HOME}" "${@}"; }
    mendo checkout
    mendo config --local status.showUntrackedFiles no
    mendo config --local core.filemode true
    mendo config --local push.default current

    if [[ "${mendokusai_os_name}" == "windows" ]]; then
        mendo config --local core.filemode false
    fi

    # shellcheck disable=SC2016
    if ! grep '[[ -r "${HOME}/.config/mendokusai/mendo.sh" ]] && . "${HOME}/.config/mendokusai/mendo.sh"' "${HOME}/.bashrc"; then
        print_info "(.bashrc) Adding Mendokusai to the PATH variable"
        # shellcheck disable=SC2016
        echo '[[ -r "${HOME}/.config/mendokusai/mendo.sh" ]] && . "${HOME}/.config/mendokusai/mendo.sh"' >>"${HOME}/.bashrc"
    fi

    # shellcheck disable=SC2016
    if ! grep '[[ -r "${HOME}/.config/mendokusai/mendo.sh" ]] && . "${HOME}/.config/mendokusai/mendo.sh"' "${HOME}/.zshrc"; then
        print_info "(.zshrc) Adding Mendokusai to the PATH variable"
        # shellcheck disable=SC2016
        echo '[[ -r "${HOME}/.config/mendokusai/mendo.sh" ]] && . "${HOME}/.config/mendokusai/mendo.sh"' >>"${HOME}/.zshrc"
    fi
    print_okay "Mendokusai has been installed successfully!"
}

main
