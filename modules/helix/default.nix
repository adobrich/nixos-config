{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "ayu_dark";
      editor = {
        mouse = false;
        true-color = true;
        soft-wrap.enable = true;
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nil"];
          formatter = {
            command = "alejandra";
            args = ["-qq"];
          };
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = ["rust-analyzer"];
        }
        {
          name = "c-sharp";
          auto-format = true;
          language-servers = ["omnisharp"];
        }
      ];
      language-server.rust-analyzer = {
        timeout = 60;
      };
    };
  };
  # Extra language packages
  home.packages = with pkgs; [alejandra rust-analyzer elixir-ls dotnet-sdk omnisharp-roslyn];
}
