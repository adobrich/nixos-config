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
    nixos-hardware.nixosModules.raspberry-pi-4
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    # pin the registry to avoid downloading and evaluating a new
    # `nixpkgs` version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  console = {
    packages = with pkgs; [terminus_font powerline-fonts];
    earlySetup = true;
    font = "ter-powerline-v28n";
    keyMap = "us";
  };

  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";

  networking = {
    networkmanager.enable = true;
    hostName = "minecraft";
    firewall = {
      enable = true;
      # allowedTCPPorts = [80 443];
      # allowedUDPPorts = [80 443];
    };
  };

  environment.systemPackages = with pkgs; [
    nano
    wget
    git
    nil
    ripgrep
    alsa-utils
  ];

  users.users.andy = {
    description = "Andrew Dobrich";
    isNormalUser = true; # Debatable
    extraGroups = [
      "audio"
      "networkmanager"
      "users"
      "video"
      "wheel"
    ];
    hashedPassword = "$6$m678eqaL0J/S3ueG$gZFG3MvnuZKhd5fkrNHh5B115z02E5KUOmu4tbefeVPP.n/xD0VVB2wpUn2PO.z2MeeT8UxZZOh09nR/hsFiL1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIInrZPGDzkLTdKgch1Yuyye0pDTLCIjdYt2FN+wGlFws andrew.dobrich@proton.me"
    ];
    shell = pkgs.fish;
  };

  programs.ssh.startAgent = true;
  programs.fish.enable = true;

  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = false;
      };
    };
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode" "UbuntuMono"];})
      liberation_ttf
      ubuntu_font_family
      work-sans
    ];

    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      defaultFonts = {
        serif = ["Work Sans"];
        sansSerif = ["Work Sans"];
        monospace = ["JetBrainsMono Nerdfont"];
      };
      hinting = {
        enable = true;
        autohint = true;
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = stateVersion;
}
