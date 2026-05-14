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

  my.desktop-utilities.enable = true;

  my.programs.bash.enable = true;
  my.programs.emacs.enable = true;
  my.programs.firefox.enable = true;
  my.programs.git.enable = true;
  my.programs.tmux.enable = true;
  my.programs.vim.enable = true;
}
