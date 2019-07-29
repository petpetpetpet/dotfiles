#!/usr/bin/env sh
# Setup shell stuff that should be common to both bash and zsh here.
# Take care not to use bash or zsh specific functionality in this
# script, as it is shared.

# DOTFILES_HOME must be set before sourcing this script.

# Source some useful PATH modification functions.
[[ -f $DOTFILES_HOME/shell/common_functions.sh ]] && source $DOTFILES_HOME/shell/common_functions.sh

DIRCOLORS_CMD="dircolors"

# When coreutils is installed on a mac, the commands
# are prefixed with 'g'. This block tries to handle that.
ISMAC=$(checkIfMac)
if [ "$ISMAC" = "true" ]
then
    DIRCOLORS_CMD="gdircolors"
    alias ls="gls --color=auto"

    # Also setup mac 'ls', even though it
    # shouldn't really be used.
    export CLICOLOR=1
    export LSCOLORS="GxFxhxhxCxbxbxCxCxGxGx"
else
    # If this isn't a mac, then 'ls' should be GNU
    # 'ls', so we don't need to alias 'gls'.
    alias ls="ls --color=auto"
fi 

# Sets the LS_COLORS environment variable which controls the colours
# GNU 'ls' displays.
[[ -e "$HOME/.dircolors" ]] && eval $($DIRCOLORS_CMD $HOME/.dircolors)

# Configure Python 3 virtualenv.
pathprepend /usr/local/bin PATH
pathprepend /usr/local/opt/python/libexec/bin PATH
export WORKON_HOME=~/.virtualenvs
VENV_WRAPPER=/usr/local/bin/virtualenvwrapper.sh
[ -f $VENV_WRAPPER ] && source $VENV_WRAPPER

# Aliases.
alias h='history'
alias wget='wget -c'
alias df='df -H'
alias du='du -ch'
alias cls='clear'
