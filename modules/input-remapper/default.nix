{pkgs, ...}: {
  services.input-remapper.enable = true;
  services.input-remapper.serviceWantedBy = ["multi-user.target"];

  systemd.user.services.input-remapper-autoload = {
    enable = true;
    description = "Load input-remapper profiles";
    after = ["input-remapper.service"];
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.input-remapper}/bin/input-remapper-control --command stop-all && ${pkgs.input-remapper}/bin/input-remapper-control --command autoload"
      ];
    };
  };
}
