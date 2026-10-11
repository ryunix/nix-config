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

  networking.hostName = "kurumi";

  my.profiles.desktop.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  system.stateVersion = "25.11";
}
