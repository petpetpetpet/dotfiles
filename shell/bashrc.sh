#!/usr/bin/env bash

# Dynamically sets DOTFILES_HOME to the root directory of your dotfiles repo.
# (This allows us to name our $HOME/dotfiles directory whatever we want.)
if [[ $0 != $BASH_SOURCE ]]
then
    # Script is being sourced. Determine DOTFILES_HOME using BASH_SOURCE.
    export DOTFILES_HOME=$(cd "$(dirname "$(realpath "$BASH_SOURCE")")/.." && pwd)
else
    # Script is being run. Determine DOTFILES_HOME using $0.
    export DOTFILES_HOME=$(cd "$(dirname "$(realpath "$0")")/.." && pwd)
fi

[[ -f $HOME/.commonrc ]] && source $HOME/.commonrc

function get_git_branch() {
    # Show the current git branch - if we are in a git repo.
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
        echo "${BRANCH}"
	else
		echo ""
	fi
}


# Setup the actual prompt string.
function make_bash_prompt()
{
    local PROMPT_CHAR='❯'

    # This code clears any assigned custom colours.
    local ENDCOLORS="\[\e[0m\]"
    if [ -z "$COLORTERM" ] && [ "$COLORTERM" = "truecolor" ]
    then
        # 24 bit colours.
        local DARKTEAL="\[\033[38;2;30;100;121m\]"
        local LIGHTBLUE="\[\033[38;2;89;156;171m\]"
        local YELLOW="\[\033[38;2;237;180;67m\]"
        local ORANGE="\[\033[38;2;210;105;55m\]"
    else
        # 256 colour approximation.
        local DARKTEAL="\[\033[38;5;23m\]"
        local LIGHTBLUE="\[\033[38;5;38m\]"
        local YELLOW="\[\033[38;5;220m\]"
        local ORANGE="\[\033[38;5;166m\]"
    fi

    # Display the prompt.
    export PS1="\n$DARKTEAL\t: $LIGHTBLUE\w $YELLOW\`get_git_branch\`\n$ORANGE$PROMPT_CHAR $ENDCOLORS"
}

make_bash_prompt

# Bash-specific Aliases.
alias ll='ls -la'
alias vi='vim'
