{pkgs, ...}: {
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set fish_greeting ""
      if test (tty) = "/dev/tty1"
        exec Hyprland &> /dev/null
      end
    '';
  };
}
