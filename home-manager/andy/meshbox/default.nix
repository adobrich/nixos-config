{stateVersion, ...}: {
  imports = [
    ../../../modules/hyprland
    ../../../modules/fish
  ];

  home = {
    username = "andy";
    homeDirectory = "/home/andy";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      BROWSER = "brave";
      EDITOR = "hx";
      TERMINAL = "alacritty";
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = stateVersion;
  };
}
