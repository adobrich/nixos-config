{
  inputs,
  lib,
  config,
  pkgs,
  stateVersion,
  ...
}: {
  imports = [
    # Shell
    ../../../modules/fish
    # Terminal
    ../../../modules/foot
    # Editor
    ../../../modules/helix
    # Cli
    ../../../modules/git
    ../../../modules/exa
    ../../../modules/bat
    ../../../modules/starship
    ../../../modules/tealdeer
    # Gui Apps
    ../../../modules/brave
    ../../../modules/steam
    ../../../modules/nextcloud
  ];
  home = {
    username = "andy";
    homeDirectory = "/home/andy";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      BROWSER = "brave";
      EDITOR = "hx";
      TERMINAL = "foot";
    };
  };

  programs = {
    home-manager.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  nixpkgs.config.allowUnfreePredicate = _: true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = stateVersion;
}
