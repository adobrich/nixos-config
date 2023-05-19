{
  description = "Andy's NixOS + home-manager config";

  # Inputs are flakes that this this flake depends on.
  # These will be passed as arguments to the `outputs` function.
  inputs = {
    # Access to stable and unstable packages
    # https://github.com/NixOS/nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Manage user environments
    # `home-manager` allows declarative configuration of user specifig (non-global)
    # packages and dotfiles
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Access to hardware optimisations and settings for specific hardware
    # https://github.com/NixOS/nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Hyprland - a dynamic tiling Wayland compositor based on wlroots that
    # doesn't sacrifice on its looks
    # https://github.com/hyprwm/Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  # The `outputs` function takes the flake dependecies declared in `inputs`
  # and produces and attribute set.
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";

    # Functions to generate packages for each system stolen from Misterio77... thanks!
    # https://github.com/Misterio77/nix-config
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
    forEachPkgs = f: forEachSystem (system: f nixpkgs.legacyPackages.${system});

    # Generate NixOS configurations
    mkNixConfig = hostName: {
      ${hostName} = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs stateVersion;};
        modules = [./hosts/${hostName}];
      };
    };

    # Generate home configurations
    # users: a list of users to generate
    # hostName: the host the user(s) will be on
    # system: the architecture
    # TODO: simplify the function.
    mkHomeConfig = users: hostName: system: (
      nixpkgs.lib.mapAttrs' (
        username: _:
          nixpkgs.lib.nameValuePair "${username}@${hostName}" (
            home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.${system};
              modules = [
                ./home-manager/${username}/${hostName}
              ];
              extraSpecialArgs = {inherit inputs outputs stateVersion;};
            }
          )
      ) (nixpkgs.lib.genAttrs users (user: user))
    );
  in {
    # Default dev shell config
    devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});

    # Nix formatter
    formatter = forEachPkgs (pkgs: pkgs.alejandra);

    # Host configurations
    nixosConfigurations =
      # Desktop
      mkNixConfig "meshbox"
      # Laptop
      // mkNixConfig "pinebook-pro";

    # Home Configurations for each user/host combo
    homeConfigurations =
      # Desktop
      mkHomeConfig ["andy" "minecraft"] "meshbox" "x86_64-linux"
      # Laptop
      // mkHomeConfig ["andy"] "pinebook-pro" "aarch64-linux";
  };
}
