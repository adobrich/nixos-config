{stateVersion, ...}: {
  imports = [
    ../../../modules/hyprland
  ];

  home = {
    username = "andy";
    homeDirectory = "/home/andy";
    sessionPath = ["$HOME/.local/bin"];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = stateVersion;
  };
}
