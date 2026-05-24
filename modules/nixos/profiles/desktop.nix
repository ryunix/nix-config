{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.profiles.desktop;
in
{
  options.my.profiles.desktop = {
    enable = lib.mkEnableOption "desktop profile";
  };

  config = lib.mkIf cfg.enable {
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
        cica
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
          [ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

          fcitx5 -d
          slstatus &
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

    environment.systemPackages = with pkgs; [
      dmenu
      st
      (slstatus.override {
        withBattery = config.my.profiles.laptop.enable;
      })
    ];

    programs.slock.enable = true;
  };
}
