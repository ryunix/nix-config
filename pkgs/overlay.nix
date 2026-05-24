final: prev: {
  cica = prev.callPackage ./cica/package.nix { };
  dwm = prev.callPackage ./dwm/package.nix { dwm = prev.dwm; };
  screenshot-tools = prev.callPackage ./screenshot-tools/package.nix { };
  slstatus = prev.callPackage ./slstatus/package.nix { slstatus = prev.slstatus; };
  st = prev.callPackage ./st/package.nix { st = prev.st; };
}
