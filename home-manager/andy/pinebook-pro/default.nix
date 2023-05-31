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
    foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerdfont:size=10";
        };
        colors = {
          foreground = "d9e0ee";
          background = "292a37";
          ## Normal/regular colors (color palette 0-7)
          regular0 = "303241"; # black
          regular1 = "ec6a88"; # red
          regular2 = "3fdaa4"; # green
          regular3 = "efb993"; # yellow
          regular4 = "3fc6de"; # blue
          regular5 = "b771dc"; # magenta
          regular6 = "6be6e6"; # cyan
          regular7 = "d9e0ee"; # white

          bright0 = "393a4d"; # bright black
          bright1 = "e95678"; # bright red
          bright2 = "29d398"; # bright green
          bright3 = "efb993"; # bright yellow
          bright4 = "26bbd9"; # bright blue
          bright5 = "b072d1"; # bright magenta
          bright6 = "59e3e3"; # bright cyan
          bright7 = "d9e0ee"; # bright white
        };
      };
    };
    wofi.enable = true;
    firefox.enable = true;
    # TODO: No ARM support currently
    # chromium = {
    #   enable = true;
    #   package = pkgs.brave;
    #   extensions = [
    #     "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    #     "nplimhmoanghlebhdiboeellhgmgommi" # Tab groups
    #     "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark reader
    #     "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
    #   ];
    # };
    starship = {
      enable = true;
      settings = {
        command_timeout = 3000;
      };
    };
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
