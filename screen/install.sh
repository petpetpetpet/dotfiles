#!/usr/bin/env bash
# Set up symlinks for shell configuration files.

. $DOTFILES_HOME/functions/functions.sh

SCRIPT_DIR=$(get_script_dir)
log_info "Deploying GNU screen configuration."

link_to_home $SCRIPT_DIR/screenrc .screenrc
