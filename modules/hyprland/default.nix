{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
in {
  options.modules.hyprland = {enable = mkEnableOption "hyprland";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprland
      wofi
      swww
      wl-clipboard
    ];

    home.file.".config/hyprland/hyprland.conf".source = ./hyprland.conf;
  };
}
