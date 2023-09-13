{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "ayu_dark";
      editor = {
        mouse = false;
        true-color = true;
        soft-wrap.enable = true;
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          language-server.command = "nil";
          formatter = {
            command = "alejandra";
            args = ["-qq"];
          };
        }
      ];
    };
  };
  # Extra language packages
  home.packages = with pkgs; [alejandra];
}
