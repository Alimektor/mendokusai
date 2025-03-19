#!/usr/bin/env -S bash -e
# Run healthcheck for .config/mendokusai files.

check_shellcheck() {
    while read -r f; do
        echo "Running 'shellcheck' check for ${f}..."
        shellcheck "${f}"
    done < <(find "${HOME}/.config/mendokusai" -type f -name "*.sh" || true)
}

run_shfmt_write() {
    while read -r f; do
        echo "Running 'shfmt -w' check for ${f}..."
        shfmt -w "${f}"
    done < <(find "${HOME}/.config/mendokusai" -type f -name "*.sh" || true)
}

check_shfmt_diff() {
    while read -r f; do
        echo "Running 'shfmt -d' check for ${f}..."
        shfmt -d "${f}"
    done < <(find "${HOME}/.config/mendokusai" -type f -name "*.sh" || true)
}

main() {
    check_shellcheck
    run_shfmt_write
    check_shfmt_diff
}

main
