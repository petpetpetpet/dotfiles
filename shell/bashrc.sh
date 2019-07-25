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

# Set the prompt, and LS colour scheme.
export CLICOLOR=1
export LSCOLORS="GxFxhxhxCxbxbxCxCxGxGx"
export PROMPT_CHAR='❯'

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "${BRANCH}${STAT}"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# Setup the actual prompt string.

# This code clears any assigned custom colours.
ENDCOLORS="\[\e[0m\]"
if [ -z "$COLORTERM" ] && [ "$COLORTERM" = "truecolor" ]
then
    # 24 bit colours.
    DARKTEAL="\[\033[38;2;30;100;121m\]"
    LIGHTBLUE="\[\033[38;2;89;156;171m\]"
    YELLOW="\[\033[38;2;237;180;67m\]"
    ORANGE="\[\033[38;2;210;105;55m\]"
else
    # 256 colour approximation.
    DARKTEAL="\[\033[38;5;23m\]"
    LIGHTBLUE="\[\033[38;5;38m\]"
    YELLOW="\[\033[38;5;220m\]"
    ORANGE="\[\033[38;5;166m\]"
fi

# Display the prompt.
export PS1="\n$DARKTEAL\t: $LIGHTBLUE\w $YELLOW\`parse_git_branch\`\n$ORANGE$PROMPT_CHAR $ENDCOLORS"

# Aliases.
alias ll='ls -la'
alias vi='vim'
alias h='history'
alias wget='wget -c'
alias df='df -H'
alias du='du -ch'
