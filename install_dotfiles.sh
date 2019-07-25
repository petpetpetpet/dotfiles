#!/usr/bin/env bash

# We cannot assume DOTFILES_HOME has been setup when this
# script is being run (because this might be a completely fresh
# environment.) Therefore, we explicitly set it here to the
# dirtectory where this script resides. Post-install DOTFILES_HOME
# will be set by shell/zshrc or shell/bashrc.rc.
SCRIPT_DIR=$(cd "$(dirname "$(realpath "$0")")" && pwd)
DOTFILES_HOME=$SCRIPT_DIR

. $SCRIPT_DIR/functions/functions.sh
. $SCRIPT_DIR/shell/commonrc.sh

function install_cfg()
{
    local cfgdir=$1
    pushd $DOTFILES_HOME/$cfgdir
    bash install.sh
    popd
}

OPTIND=1

while getopts ":m" opt; do
    case $opt in
    m)
        log_info "MacOS install requested."
        pushd $DOTFILES_HOME/macos
        bash install.sh
        popd
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        ;;
    esac
done

# Pull down all submodules.
git submodule update --init --recursive

# Now install everything else.
install_cfg shell
install_cfg vim
install_cfg tmux
install_cfg screen

log_info "Done."
