;;; init.el --- Emacs initialization file  -*- lexical-binding: t; -*-

;;; Code:

(setopt inhibit-startup-screen t
        initial-scratch-message nil)
(setq ring-bell-function #'ignore)

(setq-default indent-tabs-mode nil)

(setopt mode-line-position-column-format '(" C%C")
        mode-line-position-column-line-format '(" (%l,%C)"))
(column-number-mode 1)

(when (display-graphic-p)
  (set-face-attribute 'default nil :font (font-spec :family "Cica" :size 18))

  (set-face-attribute 'fixed-pitch nil :family 'unspecified)
  (set-face-attribute 'fixed-pitch-serif nil :family 'unspecified)
  (set-face-attribute 'variable-pitch nil :family 'unspecified)

  (set-fontset-font t 'unicode (font-spec :family "Cica"))
  (set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji") nil 'append))

;;; modus-themes
(require-theme 'modus-themes)

(setq modus-themes-to-toggle
      (if (display-graphic-p)
          '(modus-vivendi-tinted modus-operandi-tinted)
        '(modus-vivendi modus-operandi)))

(load-theme (car modus-themes-to-toggle))

;;; evil
(setq evil-want-keybinding nil)

(with-eval-after-load 'evil
  (setopt evil-ex-search-case 'sensitive
          evil-ex-search-incremental nil
          evil-search-module 'evil-search
          evil-start-of-line t
          evil-undo-system 'undo-redo
          evil-want-C-h-delete t
          evil-want-C-u-delete t
          evil-want-C-u-scroll t
          evil-want-empty-ex-last-command nil))

(evil-mode 1)

;;; evil-collection
(with-eval-after-load 'evil
  (evil-collection-init))

;;; evil-numbers
(with-eval-after-load 'evil
  (keymap-set evil-normal-state-map "C-c +" #'evil-numbers/inc-at-pt)
  (keymap-set evil-visual-state-map "C-c +" #'evil-numbers/inc-at-pt)
  (keymap-set evil-visual-state-map "C-c C-+" #'evil-numbers/inc-at-pt-incremental)

  (keymap-set evil-normal-state-map "C-c -" #'evil-numbers/dec-at-pt)
  (keymap-set evil-visual-state-map "C-c -" #'evil-numbers/dec-at-pt)
  (keymap-set evil-visual-state-map "C-c C--" #'evil-numbers/dec-at-pt-incremental))

;;; magit
(setq magit-define-global-key-bindings nil)

(keymap-global-set "C-x g" #'magit-status)
(keymap-global-set "C-c g" #'magit-dispatch)
(keymap-global-set "C-c f" #'magit-file-dispatch)

;;; mozc
(when (executable-find "mozc_emacs_helper")
  (setopt default-input-method "japanese-mozc"))

;;; treesit
(with-eval-after-load 'treesit
  (setopt treesit-font-lock-level 4))

;;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(with-eval-after-load 'markdown-mode
  (setopt markdown-indent-on-enter 'indent-and-new-item))

;;; nix-ts-mode
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-ts-mode))

;;; init.el ends here
