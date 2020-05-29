set -g fish_user_paths "/usr/local/bin" $fish_user_paths
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
# ghq + peco
function ghq_peco_repo
  set selected_repository (ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $selected_repository
    echo " $selected_repository "
    commandline -f repaint
  end
end

function fish_user_key_bindings
  bind \c] ghq_peco_repo
end

bind \cr reverse_history_search

# alias

alias playground="cd ~/Desktop/playground"
alias ls='ls -G'
alias la='ls -la'
alias ll='ls -la'
alias vi='vim'
alias gs='git status'
alias gl='git log'
alias gc='git commit'
alias gcm='git commit -m'
alias push='git push'
alias pull='git pull'
alias gd='git diff'
alias gb='git branch'
alias gsw='git switch'
alias gr='git restore'
direnv hook fish | source
# set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths
# set -g fish_user_paths "/usr/local/opt/ncurses/bin" $fish_user_paths
starship init fish | source
