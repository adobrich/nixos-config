{
  inputs,
  lib,
  config,
  pkgs,
  stateVersion,
  ...
}: {
  imports = [
    ../../../modules/hyprland
    ../../../modules/helix
    ../../../modules/git
    ../../../modules/exa
    ../../../modules/bat
    ../../../modules/foot
    ../../../modules/wofi
    ../../../modules/starship
    ../../../modules/firefox
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
    # eww = {
    #   enable = true;
    # };
    fish = {
      enable = true;
      loginShellInit = ''
        set fish_greeting ""
        if test (tty) = "/dev/tty1"
          exec Hyprland &> /dev/null
        end
      '';
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = stateVersion;
}
