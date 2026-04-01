{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    disko = {
      url = "github:nix-community/disko/v1.13.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      disko,
      ...
    }:
    {
      nixosConfigurations.archetype = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          disko.nixosModules.disko
        ];
      };

      packages.x86_64-linux.disko = disko.packages.x86_64-linux.disko;

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
