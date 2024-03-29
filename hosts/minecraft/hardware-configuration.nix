{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "usbhid"];
    initrd.kernelModules = [];
    kernelModules = [];
    extraModulePackages = [];

    loader = {
      # Bug: https://github.com/NixOS/nixpkgs/issues/173948
      generic-extlinux-compatible.enable = true;

      # systemd-boot = {
      #   enable = true;
      #   consoleMode = "max";
      # };
      # efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = {
    # TODO: change to by-label
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.end0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
