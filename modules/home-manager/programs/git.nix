{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.programs.git;
in
{
  options.my.programs.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "ryunix";
          email = "ryunix.net@gmail.com";
        };
      };
      ignores = [ "*~" ];
    };
  };
}
