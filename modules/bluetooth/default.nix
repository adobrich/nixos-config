{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.bluetooth;
in {
  options.servives.bluetooth = {enable = mkEnableOption "bluetooth";};
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
      settings = {
        General = {
          ControllerMode = "dual";
          JustWorksRepairing = "always";
          FastConnectable = true;
        };
      };
    };
  };
}
