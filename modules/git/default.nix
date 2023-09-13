{config, ...}: let
  inherit (config) home;
in {
  programs.git = {
    enable = true;
    userName = "Andrew Dobrich";
    userEmail = "andrew.dobrich@proton.me";
    delta = {
      enable = true;
      options = {
        features = "decorations";
        navigate = true;
        side-by-side = true;
      };
    };
    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    extraConfig = {
      core.editor = home.sessionVariables.EDITOR;
    };
  };
}
