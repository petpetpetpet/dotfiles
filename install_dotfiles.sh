#!/usr/bin/bash
. $DOTFILES_HOME/functions/functions.sh

SCRIPT_DIR=$(get_script_dir)

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

# Now install everything else.
install_cfg shell
install_cfg vim
install_cfg tmux
install_cfg screen

log_info "Done."
