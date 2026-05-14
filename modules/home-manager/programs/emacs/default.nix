{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.programs.emacs;
in
{
  options.my.programs.emacs = {
    enable = lib.mkEnableOption "emacs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.mozc
    ];

    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.evil
        epkgs.evil-collection
        epkgs.evil-numbers
        epkgs.magit
        epkgs.markdown-mode
        epkgs.mozc
        epkgs.nix-ts-mode
        epkgs.vdiff
        (epkgs.treesit-grammars.with-grammars (grammars: [
          grammars.tree-sitter-nix
        ]))
      ];
    };

    xdg.configFile = {
      "emacs/early-init.el".source = ./early-init.el;
      "emacs/init.el".source = ./init.el;
    };

    xresources.properties = {
      "Emacs.useXIM" = false;
    };
  };
}
