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
    nixos-hardware.nixosModules.pine64-pinebook-pro
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    ../../modules/heimer
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

  # TODO: console font seems to be reset shortly after being set. Disabling plymouth seems to fix it.  Check if there is a way to prevent plymouth from resetting the console font. Perhaps this is a driver loading issue?
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
    wireless.iwd.enable = true;
    hostName = "pinebook-pro";
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
      allowedUDPPorts = [80 443];
    };
  };

  environment.systemPackages = with pkgs; [
    nano
    wget
    git
    nil
    brightnessctl
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFhtfJrcLV69Ej3E9joq8B2AIf5JEUNzPIA6WpK/iKES andrew.dobrich@proton.me"
    ];
    shell = pkgs.fish;
  };

  # TODO: this is defined here and in the home-manager config. Can probably be removed from home-config?
  programs.fish.enable = true;

  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    # TODO: nvme won't wake after suspend. Disable lid switch for now.
    logind.extraConfig = ''
      RuntimeDirectorySize=8G
      HandleLidSwitch=ignore
      HandlePowerKey=ignore
      HandlePowerKeyLongPress=poweroff
    '';
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
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
