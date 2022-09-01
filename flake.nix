{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";

    dwm = {
      url = "github:daqueenjodi/dwm";
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
        ];

        specialArgs = {
          inherit inputs;

          dwm = inputs.dwm.packages.${system}.dwm;
        };
      };
    };
  };
}
