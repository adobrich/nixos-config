{pkgs, ...}: {
  chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "nplimhmoanghlebhdiboeellhgmgommi" # Tab groups
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark reader
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
    ];
  };
}
