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

    # Users
    ../../users/andy
    # ../../users/root
  ];
}
