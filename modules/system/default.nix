{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Enable flakes and automatic cleanup
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # System fonts and settings
  fonts = {
    # Enable `fontDir` so Flatpak applications can find fonts
    fontDir.enable = true;
    fonts = with pkgs; [
      liberation_ttf
      ubuntu_font_family
      work-sans
      noto-fonts-emoji
      noto-fonts-cjk
      (nerdfonts.override {fonts = ["JetBrainsMono" "UbuntuMono" "FiraCode"];})
    ];

    # Use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        serif = ["Work Sans" "Noto Serif"];
        sansSerif = ["Work Sans" "Noto Sans"];
        monospace = ["JetBrainsMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # Locale
  console = {
    earlySetup = true;
    keyMap = "us";
    font = "ter-powerline-v28n";
    packages = with pkgs; [terminus_font powerline-fonts];
  };

  i18n = {
    defaultLocale = "en_AU.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_AU.utf8";
      LC_IDENTIFICATION = "en_AU.utf8";
      LC_MEASUREMENT = "en_AU.utf8";
      LC_MONETARY = "en_AU.utf8";
      LC_NAME = "en_AU.utf8";
      LC_NUMERIC = "en_AU.utf8";
      LC_PAPER = "en_AU.utf8";
      LC_TELEPHONE = "en_AU.utf8";
      LC_TIME = "en_AU.utf8";
    };
  };

  time.timeZone = "Australia/Melbourne";

  networking = {
    wireless.iwd.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [443 80];
      allowedUDPPorts = [443 80];
    };
  };

  # Swap out `sudo` for `doas`
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          persist = true;
        }
      ];
    };
  };

  # Sound
  sound.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Graphics
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Extra packages
  # environment.systemPackages = with pkgs; [swww];
}
