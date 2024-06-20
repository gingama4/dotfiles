#!/usr/bin/env bash

set -euC

INSTALL_DIR="$HOME/ghq/github.com/gingama4/dotfiles"
UPDATE_SKIP=${CI:-0}
WITH_GUI=0
WITH_GIT_SIGN=0

# Show usage
function usage() {
	cat >&2 <<EOS
Usage: $0 [options]

[options]
-h | --help: Show this message
-s | --skip: Skip updationg dotfiles
-d | --dir <value> : Specify the directory to install dotfiles
--gui: Run the install scripts with GUI
--git-sign: Sign the commits with GPG key

[example]
$0 --gui --git-sign -d ~/dotfiles

EOS
	exit 1
}

# Output error message and exit
function error() {
	echo "[Error] $1" >&2
	exit 1
}

# Parse options
function parse_options() {
	while [ "$#" != 0 ]; do
		case "$1" in
		-h | --help) usage ;;
		-s | --skip) UPDATE_SKIP=1 ;;
		-d | --dir)
			shift
			INSTALL_DIR="$1"
			;;
		--gui) WITH_GUI=1 ;;
		--git-sign) WITH_GIT_SIGN=1 ;;
		*) error "Invalid option: $1" ;;
		esac
		shift
	done
}

# Update or Install dotfiles
function update_dotfiles() {
	if [ "${UPDATE_SKIP}" -ne 1 ]; then
		if [ -d "$INSTALL_DIR" ]; then
			echo "Updating dotfiles..."
			git -C "$INSTALL_DIR" pull
		else
			echo "Installing dotfiles..."
			git clone https://github.com/gingama4/dotfiles "$INSTALL_DIR"
		fi
	fi
}

# Main function
function main() {
	parse_options "$@"
	update_dotfiles
	source "$INSTALL_DIR/scripts/setup.sh"
	execute
}

main "$@"
