{

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";

    dwm = {
      url = "github:daqueenjodi/dwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    dwl = {
      url = "github:daqueenjodi/dwl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-unstable.url = "nixpkgs/nixos-unstable";
    #hyprland = {
    #  url = "github:hyprwm/Hyprland";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
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
#          inputs.hyprland.nixosModules.default
        ];

        specialArgs = {
          inherit inputs;
          pkgs-unstable = inputs.nixos-unstable.legacyPackages.${system};
          dwm = inputs.dwm.packages.${system}.dwm;
          dwl = inputs.dwl.packages.${system}.dwl;
          rs-status = inputs.rs-status.packages.${system}.dwl;
        };
      };
    };
  };
}
