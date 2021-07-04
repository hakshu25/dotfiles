fish_add_path /usr/local/bin
fish_add_path /usr/local/opt/mysql@5.7/bin
set -g theme_display_git yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_git_master_branch yes
# fish_add_path /usr/local/opt/openjdk/bin
# fish_add_path /usr/local/opt/ncurses/bin

# init
direnv hook fish | source
starship init fish | source
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

# anyenv
source (brew --prefix asdf)/asdf.fish
eval (nodenv init - | source)
fish_add_path $HOME/.pyenv/bin
eval (pyenv init --path | source)
eval (rbenv init - | source)
fish_add_path $HOME/.rbenv/bin
set GOPATH (go env GOPATH)
fish_add_path $GOPATH/bin
set DENO_DIR $HOME/deno
# set -gx VOLTA_HOME "$HOME/.volta"
# set -gx PATH "$VOLTA_HOME/bin" $PATH
fish_add_path $HOME/.krew/bin

# alias
alias playground="cd ~/Desktop/playground"
alias ls='ls -G'
alias la='ls -la'
alias ll='ls -la'
alias vi='vim'
alias gs='git status'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gc='git commit'
alias gcm='git commit -m'
alias push='git push'
alias pull='git pull'
alias gd='git diff'
alias gb='git branch'
alias gsw='git switch'
alias gr='git restore'
alias git-ghq='GHQ_ROOT=~/GitHub ghq'
alias repo='gh repo view --web'
alias aws='aws-vault exec default -- aws'
alias terraform='aws-vault exec default -- terraform'
