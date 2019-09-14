eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)

alias playground="cd ~/Desktop/playground"
alias ls='ls -G'
alias la='ls -la'
alias ll='ls -la'
alias vi='vim' 
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
  export PATH=${PYENV_ROOT}/bin:$PATH
  eval "$(pyenv init -)"
fi

