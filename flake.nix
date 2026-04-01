{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.archetype = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
  };
}

