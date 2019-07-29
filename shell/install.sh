#!/usr/bin/env bash
# Set up symlinks for shell configuration files.

. $DOTFILES_HOME/functions/functions.sh

SCRIPT_DIR=$(get_script_dir)
log_info "Deploying shell configuration for bash and zsh"

link_to_home $SCRIPT_DIR/commonrc.sh .commonrc
link_to_home $SCRIPT_DIR/bashrc.sh .bashrc
link_to_home $SCRIPT_DIR/bash_profile.sh .bash_profile
link_to_home $SCRIPT_DIR/zshrc .zshrc
