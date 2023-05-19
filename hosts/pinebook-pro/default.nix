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
    inputs.nixos-hardware.nixosModules.pine64-pinebook-pro
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

    ../../modules/system

    # Users
    ../../users/andy
    # ../../users/root
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = stateVersion;
}
