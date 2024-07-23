.DEFAULT_GOAL := help

help:
				@echo "init    => Create symlinks to home directory."
				@echo "install => Install packages"
				@echo "all => Run install and init"

all: install init install-fisher install-vim-plug

install:
				/bin/bash ./install.sh

init:
				@echo '==> Start to link dotfiles to home directory.'
				stow -v -t ~ zsh vim
				stow -v -t ~/.config starship
				stow -v -t ~/.config/fish fish
				chsh -s /opt/homebrew/bin/fish

install-fisher:
				@echo '==> Install fisher plugins'
				@fisher update

install-vim-plug:
				@echo '==> Install vim-plug plugins'
				@vim +PlugInstall +qall