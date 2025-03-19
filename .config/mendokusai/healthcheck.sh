#!/usr/bin/env -S bash -e
# Run healthcheck for Mendokusai.

# Determine script path
SCRIPT_PATH="${BASH_SOURCE[0]}"
while [[ -L "${SCRIPT_PATH}" ]]; do
    SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
    SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
    [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
# SCRIPT_BASENAME=${SCRIPT_PATH##*/}

# shellcheck disable=SC1091
. "${SCRIPT_DIR}/lib/functions.sh"

main() {
    for f in "${HOME}/.config/mendokusai/healthcheck/"*; do
        if [[ -x "${f}" ]]; then
            print_info "Running ${f}..."
            "${f}"
            print_okay "Healthcheck ${f} has been run successfully!"
        fi
    done
}

main
