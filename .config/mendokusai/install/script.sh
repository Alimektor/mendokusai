#!/usr/bin/env -S bash -xe

install_script="${HOME}/.config/mendokusai/install/install.sh"

cat "${HOME}/.config/mendokusai/lib/functions.sh" > "${install_script}"
echo >> "${install_script}"
cat "${HOME}/.config/mendokusai/install/template.sh" >> "${install_script}"
shfmt -w "${install_script}"
shellcheck "${install_script}"
