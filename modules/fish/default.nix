{pkgs, ...}: {
  programs.fish = {
    enable = true;
    # TODO: come up with a better solution for starting Hyprland
    loginShellInit = ''
      set fish_greeting ""
      if test (tty) = "/dev/tty1" && test (hostname) = "pinebook-pro"
        exec Hyprland &> /dev/null
      end
    '';
  };
}
