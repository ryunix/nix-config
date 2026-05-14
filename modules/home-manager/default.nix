{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./base.nix
    ./desktop-utilities.nix
    ./programs/bash.nix
    ./programs/emacs
    ./programs/firefox.nix
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/vim.nix
  ];
}
