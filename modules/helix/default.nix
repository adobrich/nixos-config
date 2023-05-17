{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.helix;
in {
  options.modules.helix= {enable = mkEnableOption "helix";};
  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;

      settings = {
        mouse = false;

        languages = [
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
  };
}
