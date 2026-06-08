{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = import ./hosts inputs;

      nixosModules.default = import ./modules/nixos;

      homeModules.default = import ./modules/home-manager;

      overlays.default = import ./pkgs/overlay.nix;

      packages.${system} = (import ./pkgs pkgs) // {
        disko = disko.packages.${system}.disko;
      };

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
