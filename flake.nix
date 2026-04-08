{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      home-manager,
      disko,
      ...
    }:
    {
      nixosConfigurations = {
        archetype = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/archetype/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ryunix = ./hosts/archetype/home.nix;
            }
            disko.nixosModules.disko
          ];
        };

        kurumi = nixpkgs.lib.nixosSystem {
          modules = [
            { nixpkgs.overlays = [ self.overlays.default ]; }
            ./hosts/kurumi/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ryunix = ./hosts/kurumi/home.nix;
            }
            disko.nixosModules.disko
          ];
        };
      };

      overlays.default = final: prev: {
        cica = prev.callPackage ./pkgs/cica/package.nix { };
        dwm = prev.callPackage ./pkgs/dwm/package.nix { dwm = prev.dwm; };
        st = prev.callPackage ./pkgs/st/package.nix { st = prev.st; };
      };

      packages.x86_64-linux = {
        disko = disko.packages.x86_64-linux.disko;
        cica = nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/cica/package.nix { };
        dwm = nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/dwm/package.nix { };
        st = nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/st/package.nix { };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
