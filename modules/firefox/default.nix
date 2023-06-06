{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    # TODO: check if this fixes sound
    # package = (pkgs.wrapFirefox.override {libpulseaudio = pkgs.libpressureaudio;}) pkgs.firefox-unwrapped {};
  };
}
