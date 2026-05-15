{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.profiles.laptop;
in
{
  options.my.profiles.laptop = {
    enable = lib.mkEnableOption "laptop profile";
  };

  config = lib.mkIf cfg.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };
  };
}
