{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./profiles/base.nix
    ./profiles/desktop.nix
    ./profiles/laptop.nix
  ];
}
