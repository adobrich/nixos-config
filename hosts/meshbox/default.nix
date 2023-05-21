{
  config,
  pkgs,
  inputs,
  stateVersion,
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

    # inputs.hyprland.homeManagerModules.default

    ../../modules/system

    # Users
    ../../users/andy
    # ../../users/root
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = stateVersion;
}
