#!/usr/bin/env bash
#
# Utility functions that can be used by all dotfiles
# scripts.

function log_msg()
{
    local MSG=$1
    echo `date` "$MSG"
}

function log_info()
{
    local MSG=$1
    log_msg "[INFO]: $MSG"
}

function log_warn()
{
    local MSG=$1
    log_msg "[WARN]: $MSG"
}

function log_err()
{
    local MSG=$1
    log_msg "[ERROR]: $MSG"
}

function get_script_dir()
{
    echo $(cd "$(dirname "$(realpath "$0")")" && pwd)
}

function check_file()
{
    local FILENAME=$1
    if [ -e $FILENAME ]
    then
        log_info "Confirmed $FILENAME exists."
    else
        log_err "Could not find file: $FILENAME"
        exit 1
    fi
}

function link_to_home()
{
    # Creates symlinks in $HOME to the specified file.
    # Existing symlinks are removed, existing regular files
    # are backed up.

    local ACTUAL_FILE=$(realpath $1)
    local LINK_NAME=$2

    pushd $HOME
    if [ -L $LINK_NAME ]
    then
        log_warn "Link already exists in home dir: $LINK_NAME. Unlinking."
        unlink $LINK_NAME
    fi

    if [ -f $LINK_NAME ]
    then
        local BACKUP_FILE="$LINK_NAME.bak"
        log_warn "File already exists in home dir: $LINK_NAME. Backing it up to $BACKUP_FILE"
        mv $LINK_NAME $BACKUP_FILE
    fi

    log_info "Linked \$HOME/$LINK_NAME -> $ACTUAL_FILE"
    ln -s $ACTUAL_FILE $LINK_NAME
    popd
}
