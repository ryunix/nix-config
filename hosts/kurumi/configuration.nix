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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kurumi";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tokyo";

  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
    ];
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts-color-emoji
      source-han-code-jp
      source-han-sans
      source-han-serif
    ];

    fontconfig.defaultFonts = {
      serif = [
        "Source Han Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Source Han Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "Source Han Code JP"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  services.xserver = {
    enable = true;

    displayManager.startx = {
      enable = true;
      generateScript = true;
      extraCommands = ''
        fcitx5 -d
      '';
    };

    windowManager.dwm.enable = true;
  };

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "ctrl:nocaps";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  users.users.ryunix = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    dmenu
    st
  ];

  programs.slock.enable = true;

  system.stateVersion = "25.11";
}
