{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
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
}
