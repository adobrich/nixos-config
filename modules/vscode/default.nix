{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vscode
    vscode-extensions
  ];
}
