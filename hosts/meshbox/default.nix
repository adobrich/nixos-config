{
  inputs,
  lib,
  config,
  pkgs,
  nixos-hardware,
  stateVersion,
  ...
}: {
  imports = [
    nixos-hardware.nixosModues.common.cpu.amd
    nixos-hardware.nixosModules.common.gpu.amd
    # nixos-hardware.nixosModues.common.ssd
    ./hardware-configuration.nix
  ];
}
