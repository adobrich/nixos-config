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
    # Editor
    ../../../modules/helix
    # Cli
    ../../../modules/git
    ../../../modules/exa
    ../../../modules/bat
    ../../../modules/starship
  ];
  home = {
    username = "andy";
    homeDirectory = "/home/andy";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      EDITOR = "hx";
    };
  };

  programs = {
    home-manager.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # TODO: Update to latest state on other machines, then switch
  # back to global state version
  home.stateVersion = "23.05";
}
