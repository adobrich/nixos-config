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
    ../../../modules/eza
    ../../../modules/bat
    ../../../modules/starship
    ../../../modules/tealdeer
    # Gui Apps
    ../../../modules/steam
    ../../../modules/nextcloud
    ../../../modules/calibre
    ../../../modules/firefox
    ../../../modules/vscode
  ];
  home = {
    username = "andy";
    homeDirectory = "/home/andy";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      BROWSER = "firefox";
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
