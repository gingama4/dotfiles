#!/usr/bin/env bash

set -euC

CONFIGS_DIR="${INSTALL_DIR}/.config"

# Load all scripts
function load_scripts() {
	source "${CONFIGS_DIR}/zsh/zshenv.zsh"
	source "${INSTALL_DIR}/scripts/common.sh"
	debug "$INSTALL_DIR"
	debug "$CONFIGS_DIR"

	local scripts_dir="${INSTALL_DIR}/scripts"

	debug "$scripts_dir"

	local setup_files="${scripts_dir}/**/setup.sh"

	debug "------ Load Scripts: Start -------"
	for filepath in $setup_files; do
		debug "$filepath"
		source "$filepath"
	done
	debug "------ Load Scripts: End -------"
}

# Setup cui configurations
function setup_cui() {
	title "CUI CONFIG"
	setup_xdg_config
	setup_zsh
	setup_git
	setup_lazygit
	setup_nvim
	setup_alacritty
}

# Setup gui configurations
function setup_gui() {
	title "GUI CONFIG"
	setup_i3
	setup_polybar
}

# Execute setup config
function execute_setup() {
	title "Setting up config"

	setup_cui
	debug "$WITH_GUI"
	if [[ "${WITH_GUI}" -ne 0 ]]; then
		setup_gui
	fi

	echo ""
	success "Setup is complete."
}

# Excecute setup
function execute() {
	load_scripts

	execute_setup
}
