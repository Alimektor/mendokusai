#!/usr/bin/env -S bash -e
# Run healthcheck for .local/bin/ files.

check_no_script_status() {
    echo "Running 'no script status'..."
    # shellcheck disable=SC2312
    for f in $(
               cd "${HOME}"
                             mendo ls-files | grep .local/bin/
    ); do
        script_file="${HOME}/${f}"
        if [[ -x "${script_file}" ]]; then
            echo "Running 'no script status' check for ${script_file}..."
            if grep -Eq "\-\-script\-status" "${script_file}"; then
                echo "There is script status for ${script_file}."
                echo "Use grep '--script-status' '${script_file}' for more details."
                grep -nHE "\-\-script\-status" "${script_file}"
                exit 1
            fi
        fi
    done
    echo "No script status has been found."
}

check_shellcheck() {
    # shellcheck disable=SC2312
    for f in $(
               cd "${HOME}"
                             mendo ls-files | grep .local/bin/
    ); do
        script_file="${HOME}/${f}"
        # shellcheck disable=SC2312
        if [[ -x "${script_file}" ]]; then
            # if first line with bash
            # shellcheck disable=SC2312
            if head -1 "${script_file}" | grep -q bash; then
                echo "Running 'shellcheck' check job for ${script_file}..."
                shellcheck "${script_file}"
            else
                echo "Running 'shellcheck' check job is skipped for ${script_file}. No a bash file"
            fi
        fi
    done
}

run_shfmt_write() {
    # shellcheck disable=SC2312
    for f in $(
               cd "${HOME}"
                             mendo ls-files | grep .local/bin/
    ); do
        script_file="${HOME}/${f}"
        if [[ -x "${script_file}" ]]; then
            # if first line with bash
            # shellcheck disable=SC2312
            if head -1 "${script_file}" | grep -q bash; then
                echo "Running 'shfmt -w' job for ${script_file}..."
                shfmt -w "${script_file}"
            else
                echo "Running 'shfmt -w' job is skipped for ${script_file}. No a bash file"
            fi
        fi
    done
}

check_shfmt_diff() {
    # shellcheck disable=SC2312
    for f in $(
               cd "${HOME}"
                             mendo ls-files | grep .local/bin/
    ); do
        script_file="${HOME}/${f}"
        if [[ -x "${script_file}" ]]; then
            # if first line with bash
            # shellcheck disable=SC2312
            if head -1 "${script_file}" | grep -q bash; then
                echo "Running 'shfmt -d' check job for ${script_file}..."
                shfmt -d "${script_file}"
            else
                echo "Running 'shfmt -d' check job is skipped for ${script_file}. No a bash file"
            fi
        fi
    done
}

main() {
    check_no_script_status
    check_shellcheck
    run_shfmt_write
    check_shfmt_diff
}

main
