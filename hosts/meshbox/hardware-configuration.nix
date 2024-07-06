{
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "amdgpu"
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    kernelParams = ["quiet" "fsck.mode=force"];
    extraModulePackages = [];

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

  swapDevices = [{device = "/dev/disk/by-label/swap";}];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      # driSupport = true;
      # driSupport32Bit = true;
      # setLdLibraryPath = true;
      # TODO: Crashing - comment out for now to see if that fixes the problem
      # extraPackages = with pkgs; [
      # rocm-opencl-icd
      # rocm-opencl-runtime
      # ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        ControllerMode = "dual";
        # JustWorksRepairing = "always";
        FastConnectable = true;
        Experimental = true;
      };
    };
    steam-hardware.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
