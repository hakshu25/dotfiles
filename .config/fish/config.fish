set -g fish_user_paths "/usr/local/opt/mysql@5.7/bin" $fish_user_paths
set -g theme_display_git yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_git_master_branch yes

# anyenv

eval (nodenv init - | source)
set PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT
  set PATH $PYENV_ROOT/bin:$PATH
  eval (pyenv init - | source)
end
eval (rbenv init - | source)
set PATH $HOME/.rbenv/bin:$PATH
set GOPATH (go env GOPATH)
set PATH $PATH:$GOPATH/bin
set DENO_DIR $HOME/deno

# peco & ghq
function __select_ghq_cd
  commandline | read -l buffer
  ghq list --full-path | \
  fzf --query "$buffer" | \
  read -l repository_path
  if test -n "$repository_path"
    commandline "cd ~/$repository_path"
    commandline -f execute
  end
  commandline -f repaint
end

function fish_user_key_bindings
  bind \c] __select_ghq_cd
end

# alias

alias playground="cd ~/Desktop/playground"
alias ls='ls -G'
alias la='ls -la'
alias ll='ls -la'
alias vi='vim' 
alias gs='git status'
alias gl='git log'
alias gc='git commit'
alias push='git push'
alias pull='git pull'
alias gd='git diff'
alias gb='git branch'
