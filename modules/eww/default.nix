{pkgs, ...}: {
  home.packages = with pkgs; [
    eww-wayland
  ];

  # Configuration
  home.file.".config/eww/eww.scss".source = ./eww.scss;
  home.file.".config/eww/eww.yuck".source = ./eww.yuck;
}
