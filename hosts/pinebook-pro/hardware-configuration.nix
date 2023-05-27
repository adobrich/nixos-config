{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["nvme" "usbhid"];
    initrd.kernelModules = [];
    kernelModules = [];
    extraModulePackages = [];
    kernelParams = ["quiet" "splash" "plymouth.ignore-serial-consoles"];

    plymouth.enable = true;

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/disk/by-label/swap";}
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      setLdLibraryPath = true;
    };
  };

  environment.sessionVariables = {
    PAN_MESA_DEBUG = "gl3";
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
