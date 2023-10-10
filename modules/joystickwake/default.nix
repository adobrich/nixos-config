{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    joystickwake
  ];
}
