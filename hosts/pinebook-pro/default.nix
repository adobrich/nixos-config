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
    inputs.hardware.nixosModules.pine64-pinebook-pro
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    # Global Software...

    # Users
    ../../users/andy
    ../../users/root
  ];
}
