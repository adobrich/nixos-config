{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
  ];
}
# {pkgs, ...}: {
#   programs.steam = {
#     enable = true;
#     remotePlay.openFirewall = true;
#     dedicatedServer.openFirewall = true;
#   };
# }

