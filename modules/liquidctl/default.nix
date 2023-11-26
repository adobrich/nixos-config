{
  lib,
  config,
  pkgs,
  ...
}: {
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
        "${pkgs.liquidctl}/bin/liquidctl --match NZXT set pump speed 20 30 30 50 34 60 40 70 50 80"
        "${pkgs.liquidctl}/bin/liquidctl --match NZXT set fan speed 20 40 25 60 29 80 35 90 40 100"
        "${pkgs.liquidctl}/bin/liquidctl --match NZXT set lcd screen orientation 270"
      ];
    };
    requires = ["dev-kraken.device"];
    after = ["dev-kraken.device"];
    wantedBy = ["default.target"];
  };
}
