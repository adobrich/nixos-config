{pkgs, ...}: {
  # environment.systemPackages = with pkgs; [
  #   brave
  # ];

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "nplimhmoanghlebhdiboeellhgmgommi" # Tab groups
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark reader
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
    ];
    extraOpts = {
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-AU"
        "en-GB"
      ];
    };
  };
}
