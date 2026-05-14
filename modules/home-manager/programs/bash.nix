{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.programs.bash;
in
{
  options.my.programs.bash = {
    enable = lib.mkEnableOption "bash";
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      initExtra = ''
        stty -ixon
      '';
    };
  };
}
