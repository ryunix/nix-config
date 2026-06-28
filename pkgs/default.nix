pkgs: {
  cica = pkgs.callPackage ./cica/package.nix { };
  dwm = pkgs.callPackage ./dwm/package.nix { };
  mint60 = pkgs.callPackage ./mint60/package.nix { };
  screenshot-tools = pkgs.callPackage ./screenshot-tools/package.nix { };
  slstatus = pkgs.callPackage ./slstatus/package.nix { };
  st = pkgs.callPackage ./st/package.nix { };
}
