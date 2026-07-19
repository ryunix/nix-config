{
  config,
  lib,
  pkgs,
  ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tokyo";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = lib.mkDefault "us";

  users.users.ryunix = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPM3QX1uESP9Q8xJUPDUXMIHgnPy5sr/jF2vsVz8fSMg ryunix@chiaki"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBXTDCqkN59DMp58ZYh9z/Q05/0ZvRKrMjmt2ogowOZk ryunix@kurumi"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4Z+sZtgcb510vADWx9iZxeJWxicFMd4lqasQnwuPzk ryunix@so-51a"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  programs.mosh.enable = true;

  services.netbird.enable = true;

  services.resolved.enable = true;

  hardware.keyboard.qmk.enable = true;
}
