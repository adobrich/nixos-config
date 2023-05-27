{
  description = "Andy's NixOS + home-manager config";

  # Inputs are flakes that this this flake depends on.
  # These will be passed as arguments to the `outputs` function.
  inputs = {
    # Access to stable and unstable packages
    # https://github.com/NixOS/nixpkgs
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
    };
  };

  # The `outputs` function takes the flake dependecies declared in `inputs`
  # and produces and attribute set.
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";

    # Functions to generate packages for each system stolen from Misterio77... thanks!
    # https://github.com/Misterio77/nix-config
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
    forEachPkg = f: forAllSystems (system: f nixpkgs.legacyPackages.${system});
  in {

    # Default dev shell config accessible via `nix develop`
    devShells = forEachPkg (pkgs: import ./shell.nix {inherit pkgs;});

    # Nix formatter
    formatter = forEachPkg (pkgs: pkgs.alejandra);

    # Host configurations
    nixosConfigurations = {
      # Desktop
      meshbox = nixpkgs.lib.nixosSystem {
        modules = [./hosts/meshbox];
        specialArgs = {inherit inputs outputs stateVersion;};
      };
      # Laptop
      pinebook-pro = nixpkgs.lib.nixosSystem {
        modules = [./hosts/pinebook-pro];
        specialArgs = {inherit inputs outputs nixos-hardware stateVersion;};
      };
    };

    # Home Configurations for each user/host combo
    homeConfigurations = {
      # Desktop
      "andy@meshbox" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./home-manager/andy/meshbox];
        extraSpecialArgs = {inherit inputs outputs stateVersion;};
      };
      # Laptop
      "andy@pinebook-pro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [./home-manager/andy/pinebook-pro];
        extraSpecialArgs = {inherit inputs outputs stateVersion;};
      };
    };
  };
}
