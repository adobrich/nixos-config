{pkgs, ...}: {
  # home.packages = with pkgs; [
  #   nextcloud
  # ];
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
