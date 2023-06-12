{
  inputs,
  lib,
  config,
  pkgs,
  stateVersion,
  ...
}: {
  imports = [
    # Window manager
    ../../../modules/hyprland
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
    ../../../modules/wofi
    ../../../modules/starship
    # Gui Apps
    ../../../modules/firefox
    ../../../modules/eww
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

  # TODO: move to modules

  programs = {
    home-manager.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = stateVersion;
}
