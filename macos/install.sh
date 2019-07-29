#!/usr/bin/env bash

. $DOTFILES_HOME/functions/functions.sh
. $DOTFILES_HOME/shell/commonrc.sh

function isBrewInstalled()
{
    which brew &> /dev/null
    if [ $? -eq 0 ]
    then
        echo "true"
    else
        echo "false"
    fi
}


function install_macos()
{
    # Sets up a number of MacOS settings I prefer. Uses brew
    # to install some basic sofrware I like to have.
    # Expects brew to have already been installed.
    local ISMAC=$(checkIfMac)
    local HASBREW=$(isBrewInstalled)
    
    MACOS_INSTALL_SCRIPT="$DOTFILES_HOME/macos/macos_defaults.sh"
    BREW_INSTALL_SCRIPT="$DOTFILES_HOME/macos/brew/brew_defaults.sh"

    check_file $MACOS_INSTALL_SCRIPT
    check_file $BREW_INSTALL_SCRIPT

    if [ "$ISMAC" = "true" ]
    then

        log_info "Detected MacOS. Applying MacOS settings from $MACOS_INSTALL_SCRIPT"
        bash $MACOS_INSTALL_SCRIPT

        if [ "$HASBREW" = "true" ]
        then
            log_info "Detected brew. Proceeding to install sofrware."
            bash $BREW_INSTALL_SCRIPT
            if [ $? -ne 0 ]
            then
                log_err "An error occurred running brew. Aborting."
                exit 1
            fi
        else
            log_err "Cannot install brew packages. Brew has not been installed."
        fi
    else
        log_err "Cannot install MacOS settings. This computer is not running MacOS."
    fi
}

pushd $DOTFILES_HOME
install_macos
popd

