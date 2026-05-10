final: prev: {
  cica = prev.callPackage ./cica/package.nix { };
  dwm = prev.callPackage ./dwm/package.nix { dwm = prev.dwm; };
  screenshot-tools = prev.callPackage ./screenshot-tools/package.nix { };
  st = prev.callPackage ./st/package.nix { st = prev.st; };
}
