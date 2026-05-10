inputs@{
  self,
  nixpkgs,
  home-manager,
  disko,
  ...
}:

{
  archetype = nixpkgs.lib.nixosSystem {
    modules = [
      ./archetype/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.ryunix = ./archetype/home.nix;
      }
      disko.nixosModules.disko
    ];
  };

  kurumi = nixpkgs.lib.nixosSystem {
    modules = [
      { nixpkgs.overlays = [ self.overlays.default ]; }
      ./kurumi/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.ryunix = ./kurumi/home.nix;
      }
      disko.nixosModules.disko
    ];
  };
}
