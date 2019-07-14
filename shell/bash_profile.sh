# When bash is invoked interactively, it runs .bash_profile on
# startup. When bash is invoked non-interactively (ie: via a script)
# it instead runs .bashrc.
# I see no reason why I would want different behaviour in either case.
# Thus, this file just sources the .bashrc.

[[ -f $HOME/.bashrc ]] && source $HOME/.bashrc
