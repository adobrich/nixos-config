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
    # Functions to generate packages for each system stolen from Misterio77... thanks!
    # https://github.com/Misterio77/nix-config
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
    forEachPkgs = f: forEachSystem (system: f nixpkgs.legacyPackages.${system});
  in {
    # Host configurations
    nixosConfigurations = {
      meshbox = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/meshbox];
      };

      pinebook-pro = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/pinebook-pro];
      };
    };

    # Default dev shell config
    devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});

    # Nix formatter
    formatter = forEachPkgs (pkgs: pkgs.alejandra);

    # Home Configurations for each user/host combo
    homeConfigurations = {
      "andy@meshbox" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home-manager/andy/meshbox];
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
      };

      "andy@pinebook-pro" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home-manager/andy/pinebook-pro];
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
      };
    };
  };
}
