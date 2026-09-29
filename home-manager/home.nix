{ config, pkgs, ... }:

{
  home.username = "hakshu";
  home.homeDirectory = "/Users/hakshu";

  # Do not change this even when updating Home Manager.
  # Read the Home Manager release notes before bumping it.
  home.stateVersion = "26.05";

  # CLI tools. Language runtimes are managed by mise, not here.
  home.packages = with pkgs; [
    act
    actionlint
    awscli2
    bat
    bottom
    chezmoi
    coreutils
    delta
    direnv
    dive
    eza
    fd
    fzf
    gh
    ghq
    git
    gitleaks
    gnupg
    hyperfine
    jq
    just
    lazygit
    mise
    mkcert
    neovim
    nkf
    peco
    procs
    ripgrep
    rtk
    sd
    starship
    terminal-notifier
    tokei
    tree
    vim
    zellij
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
