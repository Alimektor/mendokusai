main() {
    mendokusai_os_name=$(
        set -e
        get_os
        true
    )
    print_info "Remove old Mendokusai installation"
    rm -rf "${HOME}/.config/mendokusai"
    rm -rf "${HOME}/.config/mendokusai-git"

    print_info "Installing Mendokusai for the current user..."
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
    if ! grep -q '[[ -r "${HOME}/.config/mendokusai/mendo.sh" ]] && . "${HOME}/.config/mendokusai/mendo.sh"' "${HOME}/.bashrc"; then
        print_info "(.bashrc) Adding Mendokusai to the PATH variable"
        # shellcheck disable=SC2016
        echo '[[ -r "${HOME}/.config/mendokusai/mendo.sh" ]] && . "${HOME}/.config/mendokusai/mendo.sh"' >>"${HOME}/.bashrc"
    else
        print_warn "(.bashrc) Mendokusai is already in the PATH variable in .bashrc"
    fi

    # shellcheck disable=SC2016
    if ! grep -q '[[ -r "${HOME}/.config/mendokusai/mendo.sh" ]] && . "${HOME}/.config/mendokusai/mendo.sh"' "${HOME}/.zshrc"; then
        print_info "(.zshrc) Adding Mendokusai to the PATH variable"
        # shellcheck disable=SC2016
        echo '[[ -r "${HOME}/.config/mendokusai/mendo.sh" ]] && . "${HOME}/.config/mendokusai/mendo.sh"' >>"${HOME}/.zshrc"
    else
        print_warn "(.zshrc) Mendokusai is already in the PATH variable in .zshrc"
    fi
    print_okay "Mendokusai has been installed successfully!"
}

main
