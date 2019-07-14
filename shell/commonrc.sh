# Shell rc file that should contain startup logic that
# is applicable regardless of whether the shell is bash
# or zsh. Most stuff should go here.
[[ -f $HOME/.dotfilesrc ]] && source $HOME/.dotfilesrc

[[ -f $DOTFILES_HOME/shell/common_functions.sh ]] && source $DOTFILES_HOME/shell/common_functions.sh

# Configure Python 3 virtualenv.
pathprepend /usr/local/bin PATH
pathprepend /usr/local/opt/python/libexec/bin PATH
export WORKON_HOME=~/.virtualenvs
VENV_WRAPPER=/usr/local/bin/virtualenvwrapper.sh
[ -f $VENV_WRAPPER ] && source $VENV_WRAPPER
