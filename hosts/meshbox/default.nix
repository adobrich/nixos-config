{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Host hardware configuration
    # Kernel, bootloader and filesystem config
    ./hardware-configuration.nix
    # Hardware tweaks/quirks from nixos-hardware
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    # Global Software...
    # for a desktop installation
    ../../modules/desktop-role.nix
    # let's try hyprland
    ../../modules/hyprland.nix
    # include steam / controller support
    ../../modules/gaming.nix
    # configure bluetooth
    ../../modules/bluetooth.nix
    # include all the latest cli hotness
    ../../modules/modern-cli.nix
    # NZXT kraken AIO configuration
    ../../moduels/liquidctl.nix

    # Users
    ../../users/andy
    ../../users/root
  ];
}
