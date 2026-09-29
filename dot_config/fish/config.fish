# Use -g so PATH stays in this file instead of leaking into fish_variables
fish_add_path -g /usr/local/bin
fish_add_path -g /opt/homebrew/bin
fish_add_path -g $HOME/.deno/bin
fish_add_path -g $HOME/.local/bin
fish_add_path -g $HOME/Library/Android/sdk/platform-tools $HOME/Library/Android/sdk/emulator
# for obsidian cli
fish_add_path -g /Applications/Obsidian.app/Contents/MacOS

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
