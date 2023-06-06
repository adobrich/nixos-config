{pkgs, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 3000;
    };
  };
}
