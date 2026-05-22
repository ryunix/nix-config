{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.programs.ssh;
in
{
  options.my.programs.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*.netbird.cloud" = {
          identityFile = "~/.ssh/id_ed25519_local";
          identitiesOnly = true;
        };
      };
    };
  };
}
