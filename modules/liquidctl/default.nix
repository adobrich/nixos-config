{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.liquidctl;
in {
  options.services.liquidctl = {
    enable = mkEnableOption "liquidctl service";

    pumpSpeed = mkOption {
      type = types.str;
      default = "20 30 30 50 34 60 40 70 50 80";
    };

    fanSpeed = mkOption {
      type = types.str;
      default = "20 40 30 60 34 80 40 90 50 100";
    };

    lcdOrientation = mkOption {
      type = types.str;
      default = "270";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      liquidctl
    ];

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1e71", ATTRS{idProduct}=="3008", ATTRS{serial}=="206136704653", SYMLINK+="kraken", TAG+="systemd"
    '';

    systemd.services.kraken = {
      enable = true;
      description = "NZXT Kraken AIO startup service";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = [
          "${pkgs.liquidctl}/bin/liquidctl initialize --match NZXT"
          "${pkgs.liquidctl}/bin/liquidctl --match NZXT set pump speed ${cfg.pumpSpeed}"
          "${pkgs.liquidctl}/bin/liquidctl --match NZXT set fan speed ${cfg.fanSpeed}"
          "${pkgs.liquidctl}/bin/liquidctl --match NZXT set lcd screen orientation ${cfg.lcdOrientation}"
        ];
      };

      requires = ["dev-kraken.device"];
      after = ["dev-kraken.device"];
      wantedBy = ["default.target"];
    };
  };
}
