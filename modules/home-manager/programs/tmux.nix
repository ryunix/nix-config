{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.programs.tmux;
in
{
  options.my.programs.tmux = {
    enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-j";
      keyMode = "vi";
      terminal = "tmux";
      extraConfig = ''
        %if "#{DISPLAY}"
        set-option -s default-terminal "tmux-256color"
        %endif
      '';
    };
  };
}
