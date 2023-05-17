{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.brave;
in {
  options.modules.brave= {enable = mkEnableOption "brave";};
  config = mkIf cfg.enable {
    home.packages.chromium = {
      enable = true;
      package = pkgs.brave;
    };
    # TODO: add extensions
  };
}
