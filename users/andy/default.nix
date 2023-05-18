{
  config,
  pkgs,
  ...
}: let
  ifExists = groups:
    builtins.filter (
      group: builtins.hasAttr group config.users.groups
    )
    groups;
in {
  users.users.andy = {
    description = "Andrew Dobrich";
    isNormalUser = true; # Debateable
    extraGroups =
      [
        "audio"
        "networkmanager"
        "users"
        "video"
        "wheel"
      ]
      ++ ifExists ["docker"];

    # Generated using `mkpasswd -m sha-512`
    hashedPassword = "$6$eYJEZ1XLt1Xi/rfp$ainuYJGC2TtaG/0dc45JMsj2P3OObFtgwlmNhgKna1q8uINB044R59JShM3i9umvHMyhrrH2Pa0lgMKtvtWk71";
    openssh.authorised.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIInrZPGDzkLTdKgch1Yuyye0pDTLCIjdYt2FN+wGlFws andrew.dobrich@proton.me"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJlEFeVw4aOhY+UUPQqkWQ509M36lQMaI4Qjyvr7Qcao andrew.dobrich@protonmail.com"
    ];
    shell = pkgs.fish;
  };
}
