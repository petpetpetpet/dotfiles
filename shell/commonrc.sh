# Setup shell stuff that should be common to both bash and zsh here.
# ie: most stuff.

# Dynamically sets DOTFILES_HOME to the root directory of your dotfiles repo.
# (This allows us to name our $HOME/dotfiles directory whatever we want.)
export DOTFILES_HOME=$(cd "$(dirname "$(realpath "$0")")/.." && pwd)

# Source some useful PATH modification functions.
[[ -f $DOTFILES_HOME/shell/common_functions.sh ]] && source $DOTFILES_HOME/shell/common_functions.sh

# Configure Python 3 virtualenv.
pathprepend /usr/local/bin PATH
pathprepend /usr/local/opt/python/libexec/bin PATH
export WORKON_HOME=~/.virtualenvs
VENV_WRAPPER=/usr/local/bin/virtualenvwrapper.sh
[ -f $VENV_WRAPPER ] && source $VENV_WRAPPER
