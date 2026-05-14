{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.desktop-utilities;
in
{
  options.my.desktop-utilities = {
    enable = lib.mkEnableOption "desktop utilities";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.keepassxc
      pkgs.screenshot-tools
      pkgs.sxiv
      pkgs.xclip
    ];
  };
}
