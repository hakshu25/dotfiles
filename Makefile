.DEFAULT_GOAL := help

help:
				@echo "init    => Apply chezmoi dotfiles to home directory."
				@echo "install => Install packages"
				@echo "all => Run install and init"

all: install install-nix init install-fisher install-vim-plug

install:
				/bin/bash ./install.sh

install-nix:
				@echo '==> Running home-manager switch...'
				home-manager switch --flake .

init:
				@echo '==> Applying dotfiles with chezmoi...'
				chezmoi apply
				chsh -s /opt/homebrew/bin/fish

install-fisher:
				@echo '==> Install fisher plugins'
				@fisher update

install-vim-plug:
				@echo '==> Install vim-plug plugins'
				@vim +PlugInstall +qall