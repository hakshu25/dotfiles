CANDIDATES := $(wildcard .??* Brewfile)
EXCLUSIONS := .DS_Store .git .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

help:
				@echo "init    => Create symlinks to home directory."
				@echo "install => Install packages"
				@echo "all => Run install and init"

all: install init

install:
				/bin/bash ./install.sh

init:
				@echo '==> Start to link dotfiles to home directory.'
				@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
