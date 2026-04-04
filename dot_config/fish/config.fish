fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.deno/bin
fish_add_path $HOME/.local/bin
# for obsidian cli
fish_add_path /Applications/Obsidian.app/Contents/MacOS
set -g theme_display_git yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_git_master_branch yes

# init
starship init fish | source
mise activate fish | source
if test -f (brew --prefix)/etc/brew-wrap.fish
  source (brew --prefix)/etc/brew-wrap.fish
end

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
alias cc='claude --dangerously-skip-permissions'
