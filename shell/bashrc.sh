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
export PS1="[\h:\W]$ "
export CLICOLORS=1
export LSCOLORS="hxgxdxdxCxegedabagacad"

