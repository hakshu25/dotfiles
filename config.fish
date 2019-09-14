set PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT
  set PATH $PYENV_ROOT/bin:$PATH
  eval (pyenv init - | source)
end
