set -g fish_user_paths "/usr/local/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/mysql@5.7/bin" $fish_user_paths
set -g theme_display_git yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_git_master_branch yes
# set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths
# set -g fish_user_paths "/usr/local/opt/ncurses/bin" $fish_user_paths

# init
direnv hook fish | source
starship init fish | source
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

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
alias git-ghq='GHQ_ROOT=~/GitHub ghq'
