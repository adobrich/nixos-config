{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig = import ./config.nix {inherit (config) home;};
  };
}
