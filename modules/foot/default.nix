{...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerdfont:size=10";
      };
      colors = {
        foreground = "d9e0ee";
        background = "292a37";
        ## Normal/regular colors (color palette 0-7)
        regular0 = "303241"; # black
        regular1 = "ec6a88"; # red
        regular2 = "3fdaa4"; # green
        regular3 = "efb993"; # yellow
        regular4 = "3fc6de"; # blue
        regular5 = "b771dc"; # magenta
        regular6 = "6be6e6"; # cyan
        regular7 = "d9e0ee"; # white

        bright0 = "393a4d"; # bright black
        bright1 = "e95678"; # bright red
        bright2 = "29d398"; # bright green
        bright3 = "efb993"; # bright yellow
        bright4 = "26bbd9"; # bright blue
        bright5 = "b072d1"; # bright magenta
        bright6 = "59e3e3"; # bright cyan
        bright7 = "d9e0ee"; # bright white
      };
    };
  };
}
