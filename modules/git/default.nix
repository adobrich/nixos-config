{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.git;
in {
  options.modules.git = {enable = mkEnableOption "git";};
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Andrew Dobrich";
      userEmail = "andrew.dobrich@proton.me";
      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      extraConfig = {
        init = {defaultBranch = "main";};
        core = {
          editor = "${pkgs.helix}/bin/hx";
          excludesfile = "$NIXOS_CONFIG_DIR/scripts/global_gitignore";
        };
      };
      push = {
        default = "matching";
      };
      pull = {
        rebase = true;
      };
    };

    # Use libreSSL and start the key agent
    programs.ssh = {
      enable = true;
      package = pkgs.libressl;
      startAgent = true;
    };
  };
}
