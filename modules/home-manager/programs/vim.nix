{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.programs.vim;
in
{
  options.my.programs.vim = {
    enable = lib.mkEnableOption "vim";
  };

  config = lib.mkIf cfg.enable {
    programs.vim = {
      enable = true;
      defaultEditor = true;
      plugins = lib.mkForce [ ];
      extraConfig = ''
        set autoindent
        set backspace=indent,eol
        set hlsearch

        filetype plugin on
        syntax on

        colorscheme torte
      '';
    };
  };
}
