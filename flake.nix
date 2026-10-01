{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      # Read the current user from the environment so the same flake works on
      # machines with different usernames. Requires `--impure`.
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      # Machine type chosen on `chezmoi init` (see .chezmoi.toml.tmpl).
      chezmoiConfig = "${homeDirectory}/.config/chezmoi/chezmoi.toml";
      machine = (builtins.fromTOML (builtins.readFile chezmoiConfig)).data.machine;
    in
    assert nixpkgs.lib.assertMsg (username != "" && homeDirectory != "")
      "USER/HOME are empty. Run with --impure (e.g. `home-manager switch --flake . --impure`).";
    assert nixpkgs.lib.assertMsg (builtins.pathExists chezmoiConfig)
      "${chezmoiConfig} not found. Run `chezmoi init` first.";
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit machine; };

        modules = [
          ./home-manager/home.nix
          {
            home.username = username;
            home.homeDirectory = homeDirectory;
          }
        ];
      };
    };
}
