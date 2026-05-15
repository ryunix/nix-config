{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-configuration.nix
  ];

  networking.hostName = "chiaki";

  my.profiles.desktop.enable = true;

  system.stateVersion = "25.11";
}
