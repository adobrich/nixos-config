{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  options.modules.hyprland = {enable = mkEnableOption "hyprland";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      eww
      hyprland
      mako
      swayidle
      swww
      wl-clipboard
      wofi
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
      extraConfig = import ./config.nix {inherit (config) home;};
    };
  };
}
