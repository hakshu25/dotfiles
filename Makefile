.DEFAULT_GOAL := help

help:
	@echo "all             => Run install, init and plugin setup"
	@echo "install         => Install Homebrew, Nix and packages (runs home-manager switch)"
	@echo "install-nix     => Run home-manager switch only"
	@echo "init            => Apply chezmoi dotfiles and set up the repo"
	@echo "install-fisher  => Install fisher plugins"
	@echo "install-vim-plug => Install vim-plug plugins"

# install.sh already runs home-manager switch, so install-nix is not needed here
all: install init install-fisher install-vim-plug

install:
	/bin/bash ./install.sh

install-nix:
	@echo '==> Running home-manager switch...'
	home-manager switch --flake .

init:
	@echo '==> Applying dotfiles with chezmoi...'
	chezmoi apply
	git config core.hooksPath .githooks
	chsh -s /opt/homebrew/bin/fish

install-fisher:
	@echo '==> Install fisher plugins'
	@fish -c 'fisher update'

install-vim-plug:
	@echo '==> Install vim-plug plugins'
	@vim +PlugInstall +qall

.PHONY: help all install install-nix init install-fisher install-vim-plug
