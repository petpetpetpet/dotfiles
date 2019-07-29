#!/usr/bin/env bash
# Set up symlinks for shell configuration files.

. $DOTFILES_HOME/functions/functions.sh

SCRIPT_DIR=$(get_script_dir)
log_info "Deploying dircolors for GNU ls."

link_to_home $SCRIPT_DIR/dircolours .dircolors
