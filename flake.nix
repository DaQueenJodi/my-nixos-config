{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    dwm = {
      url = "github:daqueenjodi/dwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 };


  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      localhost = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/localhost/configuration.nix
          ./modules
          inputs.hyprland.nixosModules.default
        ];

        specialArgs = {
          inherit inputs;

          dwm = inputs.dwm.packages.${system}.dwm;
        };
      };
    };
  };
}
