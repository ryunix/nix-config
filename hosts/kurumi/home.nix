{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.username = "ryunix";
  home.homeDirectory = "/home/ryunix";

  home.stateVersion = "25.11";

  home.packages = [
    pkgs.keepassxc
    pkgs.screenshot-tools
    pkgs.sxiv
    pkgs.xclip
  ];

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      stty -ixon
    '';
  };

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

  programs.tmux = {
    enable = true;
    prefix = "C-j";
    keyMode = "vi";
    terminal = "tmux";
    escapeTime = 10;
    extraConfig = ''
      %if "#{DISPLAY}"
      set-option -s default-terminal "tmux-256color"
      %endif
    '';
  };

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
}
