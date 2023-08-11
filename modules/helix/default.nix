{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        mouse = false;
        true-color = true;
        soft-wrap.enable = true;
        theme = "ayu_dark";
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
