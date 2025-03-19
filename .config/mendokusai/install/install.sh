#!/usr/bin/env -S bash -e
# Portable functions library.
# Copyright (c) 2024 AlimeKtor
# Version: 1.0.2

export reset_color='\e[0m'
export info_color='\e[1;34m'
export warning_color='\e[1;33m'
export error_color='\e[1;31m'
export success_color='\e[1;32m'

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git_sync_repo="$(git rev-parse --show-toplevel)"
    export git_sync_repo

    git_sync_repo_basename="$(basename "${git_sync_repo}")"
    export git_sync_repo_basename

    git_username="$(git config user.name)"
    export git_username
fi

get_os() {
    local system_name=""
    # shellcheck disable=SC2034
    local version="1.0.2"
    if [[ -f /etc/os-release ]]; then
        # shellcheck disable=SC1091
        . /etc/os-release
        system_name=${NAME}
    elif type lsb_release >/dev/null 2>&1; then
        system_name=$(lsb_release -si)
    elif [[ -f /etc/lsb-release ]]; then
        # shellcheck disable=SC1091
        . /etc/lsb-release
        system_name=${DISTRIB_ID}
    elif [[ -f /etc/debian_version ]]; then
        # shellcheck disable=SC1091
        . /etc/debian_version
        system_name=Debian
    elif [[ -f /etc/SuSe-release ]]; then
        # shellcheck disable=SC1091
        . /etc/SuSe-release
        system_name=Suse
    elif [[ -f /etc/redhat-release ]]; then
        # shellcheck disable=SC1091
        . /etc/redhat-release
        system_name=redhat-release
    elif command -v termux-setup-storage >/dev/null 2>&1; then
        system_name="Termux"
    else
        system_name=$(uname -s)
    fi

    if [[ "${system_name}" =~ "Arch Linux" ]]; then
        echo "arch"
    elif [[ "${system_name}" =~ "Kali" ]]; then
        echo "kali"
    elif [[ "${system_name}" =~ "ALT" || "${ID}" == "altlinux" ]]; then
        echo "alt"
    elif [[ "${system_name}" =~ "Termux" ]]; then
        echo "termux"
    elif [[ "${system_name}" =~ "openSUSE" ]]; then
        echo "opensuse"
    elif [[ "${system_name}" =~ "Mint" ]]; then
        echo "mint"
    elif [[ "${system_name}" =~ "Raspbian" ]]; then
        echo "raspbian"
    elif [[ "${system_name}" =~ "Ubuntu" ]]; then
        echo "ubuntu"
    elif [[ "${system_name}" =~ "elementary" ]]; then
        echo "elementary"
    elif [[ "${system_name}" =~ "MINGW" || "${system_name}" =~ "CYGWIN" ]]; then
        echo "windows"
    else
        echo "unsupported"
    fi
    return 0
}

print_info() {
    local _message="${1}"
    echo -e "${info_color:-}[INFO] ${_message:-Info}${reset_color:-}"
}

print_fail() {
    local _message="$1"
    echo -e "${error_color:-}[FAIL] ${_message:-Info}${reset_color:-}" >&2
    exit 1
}

print_okay() {
    local _message="${1}"
    echo -e "${success_color:-}[OKAY] ${_message:-OK}${reset_color:-}"
}

print_warn() {
    local _message="${1}"
    echo -e "${warning_color:-}[WARN] ${_message:-Warning}${reset_color:-}"
}

print_run() {
    local _command="${1}"
    echo -e "${info_color:-}[RUN] ${success_color:-}$ ${_command}${reset_color:-}"
    eval "${_command}"
}
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
