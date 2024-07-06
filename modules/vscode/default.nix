{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csharp
      ms-dotnettools.csdevkit
      dracula-theme.theme-dracula
      ms-vscode.hexeditor
      streetsidesoftware.code-spell-checker
      yzhang.markdown-all-in-one
    ];
  };
}
