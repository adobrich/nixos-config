{pkgs, ...}: {
  programs.tealdeer.enable = true;

  home.file.".config/tealdeer/config.toml" = {
    text = ''
      [updates]
      auto_update = true
      auto_update_interval_hours = 168
    '';
  };
}
